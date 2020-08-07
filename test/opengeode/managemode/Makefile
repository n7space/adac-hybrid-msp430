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

NAME=managemode

DEVICE=msp430g2553
# A virtual MSP430G2553 "EX" device, which is an emulated MSP430G2553 with larger memory.
DEVICEEX=msp430g2553EX

TOP_DIR=$(realpath ../../../)
OUT_DIR=${TOP_DIR}/build/test/opengeode/${NAME}
UTILS_SRC_DIR=${TOP_DIR}/test/utils
BSP_SRC_DIR=${TOP_DIR}/test/bsp/${DEVICE}

ADAC=msp430-elf-adac
OBJCOPY=msp430-elf-objcopy

LOG=${OUT_DIR}/${NAME}.log
OUTPUT_PIPE=${OUT_DIR}/${NAME}.output
COMMAND_FILE=${OUT_DIR}/${NAME}.stdin

MSP430_GCC_PATH=${shell which msp430-elf-gcc}
MSP430_PATH=${shell dirname ${MSP430_GCC_PATH}}
# Custom support dir serving a virtual MSP430G2553 "EX" device files
MSP430_SUPPORT_DIR?=${realpath mcu}
ADAC_LIB_DIR?=${TOP_DIR}/build/adac/lib
EMULATOR?=${TOP_DIR}/tools/msp430-emulator/msp430-emu

LIBS=-lgnatmsp430 -lllvmmsp430 -lc

CFLAGS= -mmcu=$(DEVICE) \
		-msmall \
		-Wall \
		-Wgnat,-gnatif \
	    -Wgnat,-ISDL/wrappers \
		-Wgnat,-ISDL/code \
		-Wgnat,-I../../utils \
	 	-Wgnat,-I../../bsp/${DEVICE} \
		-Wllc,--function-sections \
		-g

LFLAGS= -L ${ADAC_LIB_DIR} -L $(MSP430_SUPPORT_DIR) -Wl,--gc-sections -T $(DEVICEEX).ld


SRC= \
	main.adb \
	envstub.adb \
	SDL/code/managemode.adb \
	SDL/wrappers/pus_c.adb \
	SDL/wrappers/taste_basictypes.adb \
	SDL/wrappers/demosat_types.adb

OBJ=$(SRC:%.adb=${OUT_DIR}/%.o) ${OUT_DIR}/utils.o ${OUT_DIR}/usci.o ${OUT_DIR}/reporting.o

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}.elf
	${OBJCOPY} -O binary $< $@

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@
	mkdir -p $@/SDL/code
	mkdir -p $@/SDL/wrappers

${OUT_DIR}/%.o: %.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/reporting.o: ${UTILS_SRC_DIR}/reporting.adb ${UTILS_SRC_DIR}/reporting.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/usci.o: ${BSP_SRC_DIR}/usci.adb ${BSP_SRC_DIR}/usci.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${OUT_DIR}/${NAME}.bin
	# Setup i/o
	rm -r -f ${LOG}
	rm -r -f ${OUTPUT_PIPE}
	rm -r -f ${COMMAND_FILE}
	touch ${OUTPUT_PIPE}
	printf "reset\ns 64000\nquit\n" \
		> ${COMMAND_FILE}
	# Run the simulator with the test binary
	${EMULATOR} -m cli -b ${OUT_DIR}/${NAME}.bin \
		-o ${OUTPUT_PIPE} \
		< ${COMMAND_FILE} \
		> ${LOG}
	# Create reference file
	printf "Set voltage OK\nIdle HK OK\nCmd mode OK\nSafe entry OK\nSuccess\n" \
		> ${OUTPUT_PIPE}.ref
	# Check the output
	diff ${OUTPUT_PIPE} ${OUTPUT_PIPE}.ref

clean:
	rm -r -f ${OUT_DIR}
