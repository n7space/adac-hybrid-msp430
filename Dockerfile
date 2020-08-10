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

#-------------------------------#
# Development/build environment #
#-------------------------------#
FROM ubuntu:19.10 as BUILD_ENV

# Meta
LABEL PROJECT_NAME="Tiny Runtime to Run Model-Based Software on Cubesats"
LABEL PROJECT_CODE="MSP"
LABEL VENDOR="N7 Space"
LABEL ARTEFACT="ADAC build environment"
LABEL DESCRIPTION="Development environment for GNAT/LLVM/GCC based hybrid ADA Compiler for MSP430"

# Variables (not part of the container ENV, not shared across stages)
ARG USER_NAME=adac
ARG HOME_DIR=/home/${USER_NAME}
ARG TOOLS_DIR=${HOME_DIR}/tools
ARG MSP430_INSTALLER=msp430-gcc-full-linux-x64-installer-8.3.2.2.run
ARG MSP430_INSTALL_DIR=${TOOLS_DIR}/msp430-gcc

# Basic utilities
RUN apt-get update && apt-get install -y \
    cmake=3.13.4-1build1 \
    g++=4:9.2.1-3.1ubuntu1 \
    gcc=4:9.2.1-3.1ubuntu1 \
    git \
    git-lfs

# Directory setup
ENV HOME=${HOME_DIR}
RUN mkdir -p ${HOME_DIR} && \
    mkdir -p ${TOOLS_DIR}

# LLVM
RUN apt-get update && apt-get install -y \
    clang=1:9.0-49~exp1 \
    llvm-dev=1:9.0-49~exp1

# GNAT
RUN apt-get update && apt-get install -y \
    gnat=8.0.1ubuntu1 \
    gprbuild=2018-6

# MSP430-GCC
COPY tools/${MSP430_INSTALLER} ${TOOLS_DIR}
RUN ${TOOLS_DIR}/${MSP430_INSTALLER} --mode unattended --prefix ${MSP430_INSTALL_DIR}
RUN rm -f ${TOOLS_DIR}/${MSP430_INSTALLER}

# PATH
ENV PATH=${PATH}:${MSP430_INSTALL_DIR}/bin

#-------------------#
# ADAC distribution #
#-------------------#
FROM BUILD_ENV as ADAC

# Meta
LABEL PROJECT_NAME="Tiny Runtime to Run Model-Based Software on Cubesats"
LABEL PROJECT_CODE="MSP"
LABEL VENDOR="N7 Space"
LABEL ARTEFACT="ADAC compiler"
LABEL DESCRIPTION="GNAT/LLVM/GCC based hybrid ADA Compiler for MSP430"

# Variables (not part of the container ENV, not shared across stages)
ARG USER_NAME=adac
ARG HOME_DIR=/home/${USER_NAME}
ARG WORK_DIR=${HOME_DIR}/workspace
ARG TEMP_DIR=${HOME_DIR}/tmp
ARG TOOLS_DIR=${HOME_DIR}/tools
ARG MSP430_INSTALL_DIR=${TOOLS_DIR}/msp430-gcc

# Directory setup (replicates the layout from run-docker.sh)
RUN mkdir -p ${TEMP_DIR} && \
    mkdir -p ${WORK_DIR} && \
    mkdir -p ${TOOLS_DIR} && \
    mkdir -p ${WORK_DIR}/src

WORKDIR ${WORK_DIR}

# PATH (not inherited from the previous stage)
ENV PATH=${PATH}:${MSP430_INSTALL_DIR}/bin

# ADAC and runtime sources
# Multiple operations for better cache utilization
COPY src/adaentry ${WORK_DIR}/src/adaentry
COPY src/gcc ${WORK_DIR}/src/gcc
COPY src/gnat-llvm ${WORK_DIR}/src/gnat-llvm
COPY src/llvm-project ${WORK_DIR}/src/llvm-project
COPY src/msp430-elf-adac ${WORK_DIR}/src/msp430-elf-adac
COPY src/gnat-runtime ${WORK_DIR}/src/gnat-runtime
COPY src/Makefile ${WORK_DIR}/src

# Build base adac binaries
RUN make -C ${WORK_DIR}/src ${WORK_DIR}/build/adac/bin

# Copy LLVM runtime sources
COPY src/llvm-runtime ${WORK_DIR}/src/llvm-runtime

# Complete build
RUN make -C ${WORK_DIR}/src all
