#!/bin/bash

## This file is part of the adac-hybrid-msp430 distribution
## Copyright (C) 2020, European Space Agency
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, version 3.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

if [ "$#" -ne 6 ]; then
    echo "Test support script for evaluating programs on MSP430 dev-boards"
    echo "Usage:"
    echo "test_on_hw PROGRAM_FILE_NAME TIME_FOR_PROGRAM_EXECUTION" \
        " SUCCESS_FUNCTION_NAME FAILURE_FUNCTION_NAME LOG_FILE_NAME IS_INTERACTIVE"
    exit 1
fi

PROGRAM_FILE_NAME=$1
TIME_FOR_PROGRAM_EXECUTION=$2
SUCCESS_FUNCTION_NAME=$3
FAILURE_FUNCTION_NAME=$4
LOG_FILE_NAME=$5
IS_INTERACTIVE=$6

CC=msp430-elf-gcc
GDB=msp430-elf-gdb

CC_PATH=$(which ${CC})
CC_DIR=$(realpath $(dirname ${CC_PATH})/..)
LOG_FILE=$(realpath $LOG_FILE_NAME)

echo $CC_DIR

echo "Starting gdb agent console"
cd $CC_DIR
./bin/gdb_agent_console msp430.dat > /dev/null &
sleep 4

BREAKPOINT_SUCCESS="'break $SUCCESS_FUNCTION_NAME'"
BREAKPOINT_FAIL="'break $FAILURE_FUNCTION_NAME'"

echo "Using" $BREAKPOINT_SUCCESS "for testing success"
echo "Using" $BREAKPOINT_FAIL "for testing failure"

echo "Launching program" $PROGRAM_FILE_NAME ", using " $LOG_FILE "for logging"

# Duplication due to bash variable evaluation
INTERACTIVE_COMMAND="$GDB $PROGRAM_FILE_NAME \
    -eval-command 'target remote :55000' \
    -eval-command 'monitor reset' \
    -eval-command 'load' \
    -eval-command 'si' \
    -eval-command 'load'"

NONINTERACTIVE_COMMAND="$GDB $PROGRAM_FILE_NAME \
    -eval-command 'target remote :55000' \
    -eval-command 'monitor reset' \
    -eval-command 'load' \
    -eval-command 'si' \
    -eval-command 'load' \
    -eval-command $BREAKPOINT_SUCCESS \
    -eval-command $BREAKPOINT_FAIL \
    -eval-command 'continue' \
    &"

if [ "$IS_INTERACTIVE" == "yes" ]; then
    echo "Command: " $INTERACTIVE_COMMAND
    eval $INTERACTIVE_COMMAND
else
    echo "Executing in autonomous mode"
    echo "Command: " $NONINTERACTIVE_COMMAND
    eval $NONINTERACTIVE_COMMAND > $LOG_FILE
fi


if [ "$IS_INTERACTIVE" != "yes" ]; then
    echo "Sleeping for" $TIME_FOR_PROGRAM_EXECUTION
    sleep $TIME_FOR_PROGRAM_EXECUTION
fi

if [ "$IS_INTERACTIVE" != "yes" ]; then
    echo "Killing gdb"
    pkill -f -e -9 "$NONINTERACTIVE_COMMAND"
fi

echo "Killing gdb agent console"
pkill -f -e -9 "./bin/gdb_agent_console msp430.dat"

sleep 1

echo "Testing output"
# Breakpoint #1 is for success. Breakpoint #2 is for failure (for manual inspection)
cat $LOG_FILE | grep -q "Breakpoint 1,"
TEST_RESULT=$?

if [ $TEST_RESULT -eq 0 ]; then
    echo "Success: " $TEST_RESULT
    exit 0
else
    echo "Failure: " $TEST_RESULT
    cat $LOG_FILE
    exit 1
fi
