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

#------------------#
# Test environment #
#------------------#
# Build the image on top of the adac distribution image
# which contains adac, llvm and ti gcc
FROM adac:adac as TEST_ENV

# Meta
LABEL PROJECT_NAME="Tiny Runtime to Run Model-Based Software on Cubesats"
LABEL PROJECT_CODE="MSP"
LABEL VENDOR="N7 Space"
LABEL ARTEFACT="ADAC compiler emulator test suite"
LABEL DESCRIPTION="Emulator based test suite for an MSP430 Ada compiler"

# msp430-emu runtime dependencies
RUN apt-get update && apt-get install -y \
    libreadline-dev \
    libssl-dev \
    libwebsockets-dev

# Setup paths
ARG USER_NAME=adac
ARG HOME_DIR=/home/${USER_NAME}
ARG WORK_DIR=${HOME_DIR}/workspace
ARG EMU_DIR=${WORK_DIR}/tools/msp430-emulator
ARG TEST_DIR=${WORK_DIR}/test
ARG TOOLS_DIR=${HOME_DIR}/tools
ARG MSP430_INSTALL_DIR=${TOOLS_DIR}/msp430-gcc
ARG ADAC_DIR=${WORK_DIR}/build/adac

# Setup environment
ENV PATH=${PATH}:${MSP430_INSTALL_DIR}/bin:${ADAC_DIR}/bin:${EMU_DIR}
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ADAC_DIR}/lib

# Source the emulator from adac:emu image
RUN mkdir -p ${EMU_DIR}
COPY --from=adac:emu /home/msp/msp430-emulator ${EMU_DIR}

# Copy utils, BSP and tests that can run on the emulator
RUN mkdir -p ${TEST_DIR}
COPY utils ${TEST_DIR}/utils
COPY bsp ${TEST_DIR}/bsp
COPY blink ${TEST_DIR}/blink
COPY uart ${TEST_DIR}/uart
COPY adainterop ${TEST_DIR}/adainterop
COPY cinterop ${TEST_DIR}/cinterop
COPY ads ${TEST_DIR}/ads
COPY opengeode/basicsdl ${TEST_DIR}/opengeode/basicsdl
COPY opengeode/managemode ${TEST_DIR}/opengeode/managemode
COPY gpr ${TEST_DIR}/gpr

# Run the tests than can run on the emulator
RUN make -C ${TEST_DIR}/blink test
RUN make -C ${TEST_DIR}/uart test
RUN make -C ${TEST_DIR}/adainterop test
RUN make -C ${TEST_DIR}/cinterop test
RUN make -C ${TEST_DIR}/ads test
RUN make -C ${TEST_DIR}/opengeode/basicsdl test
RUN make -C ${TEST_DIR}/opengeode/managemode test
RUN make -C ${TEST_DIR}/gpr test
