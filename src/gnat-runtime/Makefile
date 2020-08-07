##--------------------------------------------------------------------------##
##                                                                          ##
##                          GNAT RUN-TIME COMPONENTS                        ##
##                                                                          ##
##                  S Y S T E M . G C C _ B U I L T I N S                   ##
##                                                                          ##
##                                 S p e c                                  ##
##                                                                          ##
##                 Copyright (C) 2020, European Space Agency                ##
##                                                                          ##
## GNAT is free software;  you can  redistribute it  and/or modify it under ##
## terms of the  GNU General Public License as published  by the Free Soft- ##
## ware  Foundation;  either version 3,  or (at your option) any later ver- ##
## sion.  GNAT is distributed in the hope that it will be useful, but WITH- ##
## OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY ##
## or FITNESS FOR A PARTICULAR PURPOSE.                                     ##
##                                                                          ##
## As a special exception under Section 7 of GPL version 3, you are granted ##
## additional permissions described in the GCC Runtime Library Exception,   ##
## version 3.1, as published by the Free Software Foundation.               ##
##                                                                          ##
## You should have received a copy of the GNU General Public License and    ##
## a copy of the GCC Runtime Library Exception along with this program;     ##
## see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    ##
## <http://www.gnu.org/licenses/>.                                          ##
##                                                                          ##
## GNAT was originally developed  by the GNAT team at  New York University. ##
## Extensive contributions were provided by Ada Core Technologies Inc.      ##
##                                                                          ##
##--------------------------------------------------------------------------##

GNAT_CRT_MSP430=libgnatmsp430.a
GNAT_CRT_MSP430X=libgnatmsp430x.a

BUILD_DIR=$(shell realpath build)
SRC_DIR=$(shell realpath src)
MSP430_OBJ_DIR=${BUILD_DIR}/msp430
MSP430X_OBJ_DIR=${BUILD_DIR}/msp430x


.PHONY: all clean

all: ${BUILD_DIR}/${GNAT_CRT_MSP430} \
     ${BUILD_DIR}/${GNAT_CRT_MSP430X}

${BUILD_DIR}:
	mkdir -p $@

# The entire source must be copied, because AdaCore's llvm-gcc does not handle
# correctly relative paths and output names; make is executed within the
# directory to avoid issues with search paths
${MSP430_OBJ_DIR}: ${BUILD_DIR}
	mkdir -p $@
	cp -f ${SRC_DIR}/*.* ${MSP430_OBJ_DIR}/
	cp -f Makefile.msp430 ${MSP430_OBJ_DIR}/Makefile

# The entire source must be copied, because AdaCore's llvm-gcc does not handle
# correctly relative paths and output names; make is executed within the
# directory to avoid issues with search paths
${MSP430X_OBJ_DIR}: ${BUILD_DIR}
	mkdir -p $@
	cp -f ${SRC_DIR}/*.* ${MSP430X_OBJ_DIR}/
	cp -f Makefile.msp430x ${MSP430X_OBJ_DIR}/Makefile

${BUILD_DIR}/${GNAT_CRT_MSP430}: ${MSP430_OBJ_DIR}
	${MAKE} -C ${MSP430_OBJ_DIR}
	cp ${MSP430_OBJ_DIR}/${GNAT_CRT_MSP430} ${BUILD_DIR}/

${BUILD_DIR}/${GNAT_CRT_MSP430X}: ${MSP430X_OBJ_DIR}
	${MAKE} -C ${MSP430X_OBJ_DIR}
	cp ${MSP430X_OBJ_DIR}/${GNAT_CRT_MSP430X} ${BUILD_DIR}/

# Ifs are present to prevent a clean error if the makefiles are already deleted
clean:
ifneq ("$(wildcard $(MSP430_OBJ_DIR)/Makefile)","")
	${MAKE} -C ${MSP430_OBJ_DIR} clean
endif
ifneq ("$(wildcard $(MSP430X_OBJ_DIR)/Makefile)","")
	${MAKE} -C ${MSP430X_OBJ_DIR} clean
endif
	rm -r -f ${BUILD_DIR}
