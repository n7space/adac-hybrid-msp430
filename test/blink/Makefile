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

NAME=blink

DEVICE?=msp430g2553

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/${NAME}
UTILS_SRC_DIR=${TOP_DIR}/test/utils

ADAC=msp430-elf-adac
OBJCOPY=msp430-elf-objcopy

OUTPUT_FILE=${OUT_DIR}/${NAME}.stdout
COMMAND_FILE=${OUT_DIR}/${NAME}.stdin

MSP430_GCC_PATH=${shell which msp430-elf-gcc}
MSP430_PATH=${shell dirname ${MSP430_GCC_PATH}}
MSP430_SUPPORT_DIR?=${realpath ${MSP430_PATH}/..}/include
ADAC_LIB_DIR?=${TOP_DIR}/build/adac/lib
EMULATOR?=${TOP_DIR}/tools/msp430-emulator/msp430-emu

CFLAGS= -mmcu=$(DEVICE) \
	 -msmall \
	 -Wall \
	 -Wgnat,-I../utils \
	 -Wgnat,-I../bsp/${DEVICE}

LFLAGS= -L ${ADAC_LIB_DIR} -L $(MSP430_SUPPORT_DIR) -Wl,--gc-sections -T $(DEVICE).ld

# Libraries for MSP430G2553
LIBS= -lgnatmsp430 -lllvmmsp430 -lc

OBJ=${OUT_DIR}/blink.o \
	${OUT_DIR}/utils.o

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}.elf
	${OBJCOPY} -O binary $< $@

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

${OUT_DIR}/blink.o: blink.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${OUT_DIR}/${NAME}.bin
	# Setup i/o
	rm -r -f ${OUTPUT_FILE}
	rm -r -f ${COMMAND_FILE}
	touch ${OUTPUT_FILE}
	printf "reset\ns 10000\nquit\n" \
		> ${COMMAND_FILE}
	# Run the simulator with the test binary
	${EMULATOR} -m cli -b ${OUT_DIR}/${NAME}.bin \
		-d ${OUTPUT_FILE} \
		< ${COMMAND_FILE} \
		> /dev/null
	# Create reference file
	printf "0X0XXXXX\n1X0XXXXX\n0X0XXXXX\n1X1XXXXX\n0X0XXXXX\n0X1XXXXX\n0X0XXXXX\n" \
		> ${OUTPUT_FILE}.ref
	# Check the output
	diff ${OUTPUT_FILE} ${OUTPUT_FILE}.ref

clean:
	rm -r -f ${OUT_DIR}
