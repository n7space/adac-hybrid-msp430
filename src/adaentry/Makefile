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

LIB_NAME=libadaentry.a

CC=msp430-elf-gcc
AR=msp430-elf-ar

SRC=main.c

OBJ = $(SRC:.c=.o)

.PHONY: all clean

all: ${LIB_NAME}

%.o: %.c
	${CC} -c $< -o $@

${LIB_NAME}: ${OBJ}
	${AR} cr $@ $^

clean:
	rm -f *.o
	rm -f *.a
