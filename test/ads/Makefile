NAME=ads

DEVICE=msp430g2553

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/${NAME}
UTILS_SRC_DIR=${TOP_DIR}/test/utils
BSP_SRC_DIR=${TOP_DIR}/test/bsp/${DEVICE}

ADAC=msp430-elf-adac
OBJCOPY=msp430-elf-objcopy

LOG=${OUT_DIR}/${NAME}.log
OUTPUT_PIPE=${OUT_DIR}/${NAME}.output
COMMAND_FILE=${OUT_DIR}/${NAME}.stdin

MSP430_GCC_PATH=${shell which msp430-elf-gcc}
MSP430_PATH=${shell dirname ${MSP430_GCC_PATH}}
MSP430_SUPPORT_DIR?=${realpath ${MSP430_PATH}/..}/include
ADAC_LIB_DIR?=${TOP_DIR}/build/adac/lib
EMULATOR?=${TOP_DIR}/tools/msp430-emulator/msp430-emu

LIBS=-lgnatmsp430 -lllvmmsp430 -lc

CFLAGS= -mmcu=$(DEVICE) \
		-msmall \
		-Wall \
		-Wgnat,-gnatif \
		-Wgnat,-I../utils \
	 	-Wgnat,-I../bsp/${DEVICE} \
		-Wllc,--function-sections \
		-g

LFLAGS= -L ${ADAC_LIB_DIR} -L $(MSP430_SUPPORT_DIR) -Wl,--gc-sections -T $(DEVICE).ld


SRC= \
	main.c \
	bodylessmodule.ads

OBJ=$(SRC:%.adb=${OUT_DIR}/%.o) ${OUT_DIR}/utils.o ${OUT_DIR}/usci.o ${OUT_DIR}/reporting.o

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}.elf
	${OBJCOPY} -O binary $< $@

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} ${OBJ}
	${ADAC} ${CFLAGS} ${LFLAGS} -o $@ ${OBJ} ${LIBS}

${OUT_DIR}:
	mkdir -p $@

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
	printf "reset\ns 10000\nquit\n" \
		> ${COMMAND_FILE}
	# Run the simulator with the test binary
	${EMULATOR} -m cli -b ${OUT_DIR}/${NAME}.bin \
		-o ${OUTPUT_PIPE} \
		< ${COMMAND_FILE} \
		> ${LOG}
	# Create reference file
	printf "Success\n" \
		> ${OUTPUT_PIPE}.ref
	# Check the output
	diff ${OUTPUT_PIPE} ${OUTPUT_PIPE}.ref

clean:
	rm -r -f ${OUT_DIR}
