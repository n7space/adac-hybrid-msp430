NAME=gpr

TOP_DIR=$(realpath ../../)
OUT_DIR=${TOP_DIR}/build/test/${NAME}

GPRBUILD=gprbuild
OBJCOPY=msp430-elf-objcopy

LOG=${OUT_DIR}/${NAME}.log
OUTPUT_PIPE=${OUT_DIR}/${NAME}.output
COMMAND_FILE=${OUT_DIR}/${NAME}.stdin

EMULATOR?=${TOP_DIR}/tools/msp430-emulator/msp430-emu

MSP430_GCC_PATH=${shell which msp430-elf-gcc}
MSP430_PATH=${shell dirname ${MSP430_GCC_PATH}}

.PHONY: all clean test

all: ${OUT_DIR}/${NAME}.bin

${OUT_DIR}/${NAME}.bin: ${OUT_DIR}/${NAME}.elf
	${OBJCOPY} -O binary $< $@

# Target specific variable just for gprbuild invocation, as it cannot
# resolve the MSP430 path on its own
${OUT_DIR}/${NAME}.elf: export MSP430_INCLUDE_PATH=${realpath ${MSP430_PATH}/..}/include

${OUT_DIR}/${NAME}.elf: ${OUT_DIR} GprBuildBasedProject.gpr
	${GPRBUILD} -vh -R GprBuildBasedProject.gpr

${OUT_DIR}:
	mkdir -p $@

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
