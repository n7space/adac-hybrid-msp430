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

CONTAINER_NAME=adac

BUILD_ENV_TAG=${CONTAINER_NAME}:build_env
ADAC_TAG=${CONTAINER_NAME}:adac
EMU_TAG=${CONTAINER_NAME}:emu
TEST_TAG=${CONTAINER_NAME}:test

BUILD_DIR=build
CONTAINER_BUILD_DIR=/home/adac/workspace/build
ADAC_BIN_DIR=${BUILD_DIR}/adac/bin
ADAC_LIB_DIR=${BUILD_DIR}/adac/lib
ADAC_BINARY=${ADAC_BIN_DIR}/msp430-elf-adac
TEST_SRC_DIR=test
TEST_BUILD_DIR=${BUILD_DIR}/test
EMU_DIR=tools/msp430-emulator

ADAC_DIST=adac.tar.gz
ADAC_ID_FILE=adac_cid.id
EMU_ID_FILE=emu_cid.id

EMU=${EMU_DIR}/msp430-emu

export PATH:=${PATH}:${realpath ${ADAC_BIN_DIR}}:${realpath ${EMU_DIR}}

.PHONY: all test hwtest emutest dockertest clean

all: ${BUILD_DIR}/${ADAC_DIST} ${ADAC_BINARY} dockertest

${ADAC_BINARY}: ${BUILD_DIR}/${ADAC_DIST}
	tar -xf ${BUILD_DIR}/${ADAC_DIST} -C ${BUILD_DIR}
	touch -m ${ADAC_BINARY}

${BUILD_DIR}/${ADAC_DIST}: ${ADAC_ID_FILE}
ifeq ("$(wildcard $(BUILD_DIR))","")
	mkdir -p ${BUILD_DIR}
endif
	docker cp $(shell cat ${ADAC_ID_FILE}):${CONTAINER_BUILD_DIR}/${ADAC_DIST} ${BUILD_DIR}/${ADAC_DIST}
	touch -m ${BUILD_DIR}/${ADAC_DIST}

# ADAC_ID_FILE must be created in a rule called before $(shell ...), otherwise cat will execute before it is created.
# docker build is invoked here, because reliance on adac target
# causes unnecessary rebuilds.
${ADAC_ID_FILE}:
	# Make sure the ID does not exist, otherwise docker will try to run an incorrect container
	rm -f ${ADAC_ID_FILE}
	docker build --tag ${ADAC_TAG} --target ADAC .
	docker run --cidfile ${ADAC_ID_FILE} ${ADAC_TAG}

adac:
	docker build --tag ${ADAC_TAG} --target ADAC .

build_env:
	docker build --tag ${BUILD_ENV_TAG} --target BUILD_ENV .

${NATIVE_EMU}: ${EMU_DIR}
	${MAKE} -C ${EMU_DIR} test

${EMU_ID_FILE}: ${EMU_DIR}
	rm -f ${EMU_ID_FILE}
	docker build --tag ${EMU_TAG} ${EMU_DIR}
	docker run --cidfile ${EMU_ID_FILE} ${EMU_TAG}

# Test target that can be invoked manually
# Requires a proper system setup with ti gcc, llvm and
# MSP430FR5969 dev-board
test: emutest hwtest

# Self-contained test target that runs within a docker image
# and executes only the tests running on an emulator
dockertest: ${ADAC_ID_FILE} ${EMU_ID_FILE}
	docker build --tag ${TEST_TAG} ${TEST_SRC_DIR}

${TEST_BUILD_DIR}:
	mkdir -p $@

emutest: ${ADAC_BINARY} ${TEST_BUILD_DIR} ${NATIVE_EMU}
	${MAKE} -C ${TEST_SRC_DIR}/blink test
	${MAKE} -C ${TEST_SRC_DIR}/uart test
	${MAKE} -C ${TEST_SRC_DIR}/adainterop test
	${MAKE} -C ${TEST_SRC_DIR}/cinterop test
	${MAKE} -C ${TEST_SRC_DIR}/ads test
	${MAKE} -C ${TEST_SRC_DIR}/opengeode/basicsdl test
	${MAKE} -C ${TEST_SRC_DIR}/opengeode/managemode test

hwtest: ${ADAC_BINARY} ${TEST_BUILD_DIR} ${NATIVE_EMU}
	${MAKE} -C ${TEST_SRC_DIR}/asn1scc/rtl test
	${MAKE} -C ${TEST_SRC_DIR}/asn1scc/rtl2 test
	${MAKE} -C ${TEST_SRC_DIR}/intmath test
	${MAKE} -C ${TEST_SRC_DIR}/floatmath test

clean:
	${MAKE} -C ${EMU_DIR} clean
	${MAKE} -C ${TEST_SRC_DIR}/blink clean
	${MAKE} -C ${TEST_SRC_DIR}/uart clean
	${MAKE} -C ${TEST_SRC_DIR}/asn1scc/rtl clean
	${MAKE} -C ${TEST_SRC_DIR}/intmath clean
	${MAKE} -C ${TEST_SRC_DIR}/floatmath clean
	${MAKE} -C src clean
	rm -f ${BUILD_DIR}/${ADAC_DIST}
	rm -f ${ADAC_ID_FILE}
	rm -f ${EMU_ID_FILE}
