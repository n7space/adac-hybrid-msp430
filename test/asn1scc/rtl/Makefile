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

NAME=asn1scc_rtl_test

DEVICE?=msp430fr5969

TOP_DIR=$(realpath ../../../)
OUT_DIR=${TOP_DIR}/build/test/asn1scc/rtl
UTILS_SRC_DIR=${TOP_DIR}/test/utils
LOG_FILE=$(OUT_DIR)/test.log

ADAC=msp430-elf-adac
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
	-Wgnat,-I../../utils \
	-Wgnat,-I../../bsp/${DEVICE} \
	-Wllc,--function-sections \
	-Wllc,--data-sections

LFLAGS= -L ${ADAC_LIB_DIR} \
	-L $(SUPPORT_FILE_DIRECTORY) \
	-Wl,--gc-sections \
	-T $(DEVICE).ld

# Libraries for MSP430FR5969
LIBS= -lllvmmsp430x -lgnatmsp430x -lc

TEST_TIMEOUT=15

SRC= \
	main.adb \
	bitstreambase.adb \
	bitstreamintegers.adb \
	adaasn1rtl.adb \
	uper_asn1_rtl.adb \
	acn_asn1_rtl.adb

# test_cases_aux.adb
# GNAT RT error - relies on FS IO

# xer_rtl.adb
#LLVM ERROR: Cannot select: 0x9e7550: f80,ch = load<(load 8 from %fixed-stack.5, align 2), anyext from f64> 0x8143a8, FrameIndex:i16<-1>, undef:i16
#  0x9e9e30: i16 = FrameIndex<-1>
#  0x9e1ba8: i16 = undef
#In function: xer_rtl__xer_encodereal

# fast_spark.adb
# File with body commented out, does not compile:
# fast_spark.adb:9:01: spec of this package does not allow a body


OBJ=$(SRC:%.adb=${OUT_DIR}/%.o)

AUX_OBJ=${OUT_DIR}/utils.o

.PHONY: all test clean

all: ${OUT_DIR}/${NAME}

${OUT_DIR}/${NAME}: ${OUT_DIR} ${OBJ} ${AUX_OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${AUX_OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

${OUT_DIR}/%.o: %.adb
	${ADAC} ${CFLAGS} -o $@ -c $<

${OUT_DIR}/utils.o: ${UTILS_SRC_DIR}/utils.adb ${UTILS_SRC_DIR}/utils.ads
	${ADAC} ${CFLAGS} -o $@ -c $<

test: ${OUT_DIR}/${NAME}
	rm -f ${LOG_FILE}
	${SVF} $(realpath ${OUT_DIR}/${NAME}) ${TEST_TIMEOUT} main__success main__failure ${LOG_FILE} no

clean:
	rm -r -f ${OUT_DIR}
