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

NAME=intmath

DEVICE?=msp430fr5969

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/intmath
UTILS_SRC_DIR=${TOP_DIR}/test/utils
LOG_FILE=$(OUT_DIR)/test.log

ADAC=msp430-elf-adac
OBJCOPY=msp430-elf-objcopy
SVF=${TOP_DIR}/test/test_on_hw.sh

TI_GCC=msp430-elf-gcc
TI_GCC_PATH=${shell which ${TI_GCC}}
TI_GCC_DIR=${shell realpath ${shell dirname ${TI_GCC_PATH}}/..}
SUPPORT_FILE_DIRECTORY=${TI_GCC_DIR}/include
ADAC_LIB_DIR=${TOP_DIR}/build/adac/lib

CFLAGS= -mmcu=$(DEVICE) \
	-msmall \
	-Wall \
	-g \
	-Wgnat,-I../utils \
	-Wgnat,-I../bsp/${DEVICE} \
	-Wllc,--function-sections \
	-Wllc,--data-sections

LFLAGS= -L ${ADAC_LIB_DIR} \
	-L $(SUPPORT_FILE_DIRECTORY) \
	-Wl,--gc-sections \
	-T $(DEVICE).ld

# Libraries for MSP430FR5969
LIBS= -lllvmmsp430x -lgnatmsp430x -lc

TEST_TIMEOUT=15

OBJ=${OUT_DIR}/intmath.o \
	${OUT_DIR}/utils.o

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}
	${OBJCOPY} -O binary $< $@

${OUT_DIR}/${NAME}: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

${OUT_DIR}/intmath.o: intmath.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${OUT_DIR}/${NAME}
	rm -f ${LOG_FILE}
	${SVF} $(realpath ${OUT_DIR}/${NAME}) ${TEST_TIMEOUT} main__success main__failure ${LOG_FILE} no

clean:
	rm -r -f ${OUT_DIR}
