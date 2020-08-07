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

NAME=uart

DEVICE?=msp430g2553

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/${NAME}
UTILS_SRC_DIR=${TOP_DIR}/test/utils
BSP_SRC_DIR=${TOP_DIR}/test/bsp/${DEVICE}

ADAC=msp430-elf-adac
OBJCOPY=msp430-elf-objcopy

INPUT_PIPE=${OUT_DIR}/${NAME}.input
OUTPUT_PIPE=${OUT_DIR}/${NAME}.output
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
	 -Wgnat,-I../bsp/${DEVICE} \
	 -Wgnat,-Os

LFLAGS= -L ${ADAC_LIB_DIR} -L $(MSP430_SUPPORT_DIR) -Wl,--gc-sections -T $(DEVICE).ld

# Libraries for MSP430G2553
LIBS= -lgnatmsp430 -lllvmmsp430 -lc

OBJ=${OUT_DIR}/uart.o \
	${OUT_DIR}/utils.o \
	${OUT_DIR}/usci.o

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}.elf
	${OBJCOPY} -O binary $< $@

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

${OUT_DIR}/${NAME}.o: ${NAME}.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/usci.o: ${BSP_SRC_DIR}/usci.adb ${BSP_SRC_DIR}/usci.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${OUT_DIR}/${NAME}.bin
	# Setup i/o
	rm -r -f ${OUTPUT_PIPE}
	rm -r -f ${INPUT_PIPE}
	rm -r -f ${COMMAND_FILE}
	touch ${OUTPUT_PIPE}
	printf "reset\ns 10000\nquit\n" \
		> ${COMMAND_FILE}
	printf "Sputnik;" \
		> ${INPUT_PIPE}
	# Run the simulator with the test binary
	${EMULATOR} -m cli -b ${OUT_DIR}/${NAME}.bin \
		-i ${INPUT_PIPE} \
		-o ${OUTPUT_PIPE} \
		< ${COMMAND_FILE} \
		> /dev/null
	# Create reference file
	printf "Hello!Echo:Sputnik" \
		> ${OUTPUT_PIPE}.ref
	# Check the output
	diff ${OUTPUT_PIPE} ${OUTPUT_PIPE}.ref

clean:
	rm -r -f ${OUT_DIR}
