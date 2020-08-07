##===-- Makefile ----------------------------------------------------------===##
##
## Part of the msp430-elf-adac Project, based on LLVM Project,
## under the Apache License v2.0 with LLVM Exceptions.
## See https://llvm.org/LICENSE.txt for license information.
## SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
##
##===----------------------------------------------------------------------===##

LLVM_CRT_MSP430=libllvmmsp430.a
LLVM_CRT_MSP430X=libllvmmsp430x.a

BUILD_DIR=build
SRC_DIR=src
MSP430_OBJ_DIR=${BUILD_DIR}/obj/msp430
MSP430X_OBJ_DIR=${BUILD_DIR}/obj/msp430x

CC=msp430-elf-gcc
AR=msp430-elf-ar

CFLAGS_COMMON= \
	-msmall \
	-Os \
	-ffunction-sections \
	-fdata-sections \
	-D__SOFT_FP__

# MSP430g2553 is representative of the MSP430 instruction set familiy
CFLAGS_MSP430= \
	${CFLAGS_COMMON} \
	-mmcu=msp430g2553

# MSP430fr5969 is representative of the MSP430X instruction set familiy
CFLAGS_MSP430X= \
	${CFLAGS_COMMON} \
	-mmcu=msp430fr5969

.PHONY: all clean

all: ${BUILD_DIR}/${LLVM_CRT_MSP430} \
     ${BUILD_DIR}/${LLVM_CRT_MSP430X}

${MSP430_OBJ_DIR}/%.o: ${SRC_DIR}/%.c
	${CC} ${CFLAGS_MSP430} -c $< -o $@

${MSP430X_OBJ_DIR}/%.o: ${SRC_DIR}/%.c
	${CC} ${CFLAGS_MSP430X} -c $< -o $@

CRT_SRC= \
	mulosi4.c \
	mulodi4.c \
	bridge.c

# Files that do not compile properly using msp430-elf-gcc
# atomic.c \
# atomic_flag_clear.c \
# atomic_flag_clear_explicit.c \
# atomic_flag_test_and_set.c \
# atomic_flag_test_and_set_explicit.c \
# atomic_signal_fence.c \
# atomic_thread_fence.c \
# emutls.c \
# enable_execute_stack.c \
# eprintf.c \

# Files that are not neccessary and may conflict with gcc built-ins
#	absvdi2.c \
#	absvsi2.c \
#	absvti2.c \
#	adddf3.c \
#	addsf3.c \
#	addtf3.c \
#	addvdi3.c \
#	addvsi3.c \
#	addvti3.c \
#	apple_versioning.c \
#	ashldi3.c \
#	ashlti3.c \
#	ashrdi3.c \
#	ashrti3.c \
#	bswapdi2.c \
#	bswapsi2.c \
#	clear_cache.c \
#	clzdi2.c \
#	clzsi2.c \
#	clzti2.c \
#	cmpdi2.c \
#	cmpti2.c \
#	comparedf2.c \
#	comparesf2.c \
#	comparetf2.c \
#	cpu_model.c \
#	ctzdi2.c \
#	ctzsi2.c \
#	ctzti2.c \
#	divdc3.c \
#	divdf3.c \
#	divdi3.c \
#	divmoddi4.c \
#	divmodsi4.c \
#	divsc3.c \
#	divsf3.c \
#	divsi3.c \
#	divtc3.c \
#	divtf3.c \
#	divti3.c \
#	divxc3.c \
#	extenddftf2.c \
#	extendhfsf2.c \
#	extendsfdf2.c \
#	extendsftf2.c \
#	ffsdi2.c \
#	ffssi2.c \
#	ffsti2.c \
#	fixdfdi.c \
#	fixdfsi.c \
#	fixdfti.c \
#	fixsfdi.c \
#	fixsfsi.c \
#	fixsfti.c \
#	fixtfdi.c \
#	fixtfsi.c \
#	fixtfti.c \
#	fixunsdfdi.c \
#	fixunsdfsi.c \
#	fixunsdfti.c \
#	fixunssfdi.c \
#	fixunssfsi.c \
#	fixunssfti.c \
#	fixunstfdi.c \
#	fixunstfsi.c \
#	fixunstfti.c \
#	fixunsxfdi.c \
#	fixunsxfsi.c \
#	fixunsxfti.c \
#	fixxfdi.c \
#	fixxfti.c \
#	floatdidf.c \
#	floatdisf.c \
#	floatditf.c \
#	floatdixf.c \
#	floatsidf.c \
#	floatsisf.c \
#	floatsitf.c \
#	floattidf.c \
#	floattisf.c \
#	floattitf.c \
#	floattixf.c \
#	floatundidf.c \
#	floatundisf.c \
#	floatunditf.c \
#	floatundixf.c \
#	floatunsidf.c \
#	floatunsisf.c \
#	floatunsitf.c \
#	floatuntidf.c \
#	floatuntisf.c \
#	floatuntitf.c \
#	floatuntixf.c \
#	fp_mode.c \
#	gcc_personality_v0.c \
#	int_util.c \
#	lshrdi3.c \
#	lshrti3.c \
#	mingw_fixfloat.c \
#	moddi3.c \
#	modsi3.c \
#	modti3.c \
#	muldc3.c \
#	muldf3.c \
#	muldi3.c \
#	muloti4.c \
#	mulsc3.c \
#	mulsf3.c \
#	multc3.c \
#	multf3.c \
#	multi3.c \
#	mulvdi3.c \
#	mulvsi3.c \
#	mulvti3.c \
#	mulxc3.c \
#	negdf2.c \
#	negdi2.c \
#	negsf2.c \
#	negti2.c \
#	negvdi2.c \
#	negvsi2.c \
#	negvti2.c \
#	os_version_check.c \
#	paritydi2.c \
#	paritysi2.c \
#	parityti2.c \
#	popcountdi2.c \
#	popcountsi2.c \
#	popcountti2.c \
#	powidf2.c \
#	powisf2.c \
#	powitf2.c \
#	powixf2.c \
#	subdf3.c \
#	subsf3.c \
#	subtf3.c \
#	subvdi3.c \
#	subvsi3.c \
#	subvti3.c \
#	trampoline_setup.c \
#	truncdfhf2.c \
#	truncdfsf2.c \
#	truncsfhf2.c \
#	trunctfdf2.c \
#	trunctfsf2.c \
#	ucmpdi2.c \
#	ucmpti2.c \
#	udivdi3.c \
#	udivmoddi4.c \
#	udivmodsi4.c \
#	udivmodti4.c \
#	udivsi3.c \
#	udivti3.c \
#	umoddi3.c \
#	umodsi3.c \
#	umodti3.c

${BUILD_DIR}:
	mkdir -p $@

${MSP430_OBJ_DIR}: ${BUILD_DIR}
	mkdir -p $@

${MSP430X_OBJ_DIR}: ${BUILD_DIR}
	mkdir -p $@


MSP430_CRT_OBJ=${patsubst %.c, ${MSP430_OBJ_DIR}/%.o, ${CRT_SRC}}
MSP430X_CRT_OBJ=${patsubst %.c, ${MSP430X_OBJ_DIR}/%.o, ${CRT_SRC}}

${BUILD_DIR}/${LLVM_CRT_MSP430}: ${MSP430_OBJ_DIR} ${MSP430_CRT_OBJ}
	${AR} cr $@ ${MSP430_CRT_OBJ}

${BUILD_DIR}/${LLVM_CRT_MSP430X}: ${MSP430X_OBJ_DIR} ${MSP430X_CRT_OBJ}
	${AR} cr $@ ${MSP430X_CRT_OBJ}

clean:
	rm -r -f ${BUILD_DIR}
