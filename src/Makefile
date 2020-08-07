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

PROJECT=adac

# Realpath is necessary because PWD does not work properly when make is called with -C
TEMP_DIR=$(realpath ../../tmp)
TOP_DIR=$(realpath ../)
BUILD_DIR=${TOP_DIR}/build
ADAC_DIR=${BUILD_DIR}/${PROJECT}
ADAC_BIN_DIR=${ADAC_DIR}/bin
ADAC_LIB_DIR=${ADAC_DIR}/lib

ADAC_DIST=adac.tar.gz

LLVM_CRT_MSP430=libllvmmsp430.a
LLVM_CRT_MSP430X=libllvmmsp430x.a

GNAT_CRT_MSP430=libgnatmsp430.a
GNAT_CRT_MSP430X=libgnatmsp430x.a

ADA_ENTRY=libadaentry.a
ADAC=msp430-elf-adac
ADABIND=msp430-elf-adabind

GNAT_SO_LIB_SRC_PATH=/usr/lib/x86_64-linux-gnu

GNAT_SOS=\
	${GNAT_SO_LIB_SRC_PATH}/libgnat-8.so \
	${GNAT_SO_LIB_SRC_PATH}/libgnat.so \
	${GNAT_SO_LIB_SRC_PATH}/libgnat-8.so.1

.PHONY: all clean

all: \
	${BUILD_DIR}/${ADAC_DIST} \
	${ADAC_BIN_DIR} \
	${ADAC_LIB_DIR}/${LLVM_CRT_MSP430} \
	${ADAC_LIB_DIR}/${LLVM_CRT_MSP430X} \
	${ADAC_LIB_DIR}/${GNAT_CRT_MSP430} \
	${ADAC_LIB_DIR}/${GNAT_CRT_MSP430X}

clean:
	rm -r -f ${ADAC_DIR}

# Create distribution containing executables and libraries
${BUILD_DIR}/${ADAC_DIST}: ${ADAC_BIN_DIR} ${ADAC_LIB_DIR}/${LLVM_CRT_MSP430} ${ADAC_LIB_DIR}/${GNAT_CRT_MSP430} ${ADAC_LIB_DIR}/${ADA_ENTRY}
	cd ${BUILD_DIR} && tar -czf ${ADAC_DIST} ${PROJECT}

# Compile GNAT runtime and copy it
${ADAC_LIB_DIR}/${GNAT_CRT_MSP430}: ${TEMP_DIR}/gnat-runtime ${ADAC_LIB_DIR} ${ADAC_BIN_DIR}
	export PATH=${PATH}:${ADAC_BIN_DIR}; ${MAKE} -C ${TEMP_DIR}/gnat-runtime
	cp -f ${TEMP_DIR}/gnat-runtime/build/${GNAT_CRT_MSP430} ${ADAC_LIB_DIR}
	cp -f ${TEMP_DIR}/gnat-runtime/build/${GNAT_CRT_MSP430X} ${ADAC_LIB_DIR}

# Compile GNAT-LLVM binaries and copy them, together with the necessary includes
# Includes from gnat-runtime override the includes from llvm-interface
${ADAC_BIN_DIR}: ${TEMP_DIR}/gnat-llvm/llvm-interface/gnat_src ${ADAC_DIR} ${ADAC_LIB_DIR} ${GNAT_SOS} msp430-elf-adac/${ADAC} gnat-runtime
	${MAKE} -j -C ${TEMP_DIR}/gnat-llvm
	cp -r -f ${TEMP_DIR}/gnat-llvm/llvm-interface/bin ${ADAC_DIR}
	mkdir -p ${ADAC_LIB_DIR}/rts-native/adainclude
	mkdir -p ${ADAC_LIB_DIR}/rts-native/adalib
	cp -r -f ${TEMP_DIR}/gnat-llvm/llvm-interface/lib/rts-native/adainclude/*.ad* ${ADAC_LIB_DIR}/rts-native/adainclude
	find ${TEMP_DIR}/ -name 'system*.ali'
	cp -r -f ${TEMP_DIR}/gnat-llvm/llvm-interface/lib/rts-native/adalib/*.ali ${ADAC_LIB_DIR}/rts-native/adalib
	cp -r -f gnat-runtime/src/*.* ${ADAC_LIB_DIR}/rts-native/adainclude
	cp -f ${GNAT_SOS} ${ADAC_LIB_DIR}
	cp -f msp430-elf-adac/${ADAC} ${ADAC_BIN_DIR}
	cp -f msp430-elf-adac/${ADABIND} ${ADAC_BIN_DIR}

# Compile LLVM compiler runtime and copy the library
${ADAC_LIB_DIR}/${LLVM_CRT_MSP430}: ${TEMP_DIR}/llvm-runtime ${ADAC_LIB_DIR}
	${MAKE} -C ${TEMP_DIR}/llvm-runtime
	cp ${TEMP_DIR}/llvm-runtime/build/${LLVM_CRT_MSP430} ${ADAC_LIB_DIR}
	cp ${TEMP_DIR}/llvm-runtime/build/${LLVM_CRT_MSP430X} ${ADAC_LIB_DIR}

# Compile C to Ada entry bridge
${ADAC_LIB_DIR}/${ADA_ENTRY}: ${TEMP_DIR}/adaentry ${ADAC_LIB_DIR}
	${MAKE} -C ${TEMP_DIR}/adaentry
	cp -f ${TEMP_DIR}/adaentry/${ADA_ENTRY} ${ADAC_LIB_DIR}

# Directory targets
${ADAC_LIB_DIR}:
	mkdir -p $@

${ADAC_DIR}:
	mkdir -p $@

# Create the required directory structure in temp, including the necessary symlink
${TEMP_DIR}/adaentry: adaentry
	cp -r -f $< ${TEMP_DIR}

${TEMP_DIR}/gnat-llvm: gnat-llvm
	cp -r -f gnat-llvm ${TEMP_DIR}

${TEMP_DIR}/gnat-llvm/llvm-interface/gcc: ${TEMP_DIR}/gnat-llvm gcc
	cp -r -f gcc ${TEMP_DIR}/gnat-llvm/llvm-interface

${TEMP_DIR}/gnat-llvm/llvm-interface/gnat_src: ${TEMP_DIR}/gnat-llvm/llvm-interface/gcc
	ln -f -s ${TEMP_DIR}/gnat-llvm/llvm-interface/gcc/gcc/ada ${TEMP_DIR}/gnat-llvm/llvm-interface/gnat_src

${TEMP_DIR}/llvm-runtime: llvm-runtime
	cp -r -f llvm-runtime ${TEMP_DIR}

${TEMP_DIR}/gnat-runtime: gnat-runtime
	cp -r -f $< ${TEMP_DIR}
