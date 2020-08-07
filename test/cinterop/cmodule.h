// This file is part of the adac-hybrid-msp430 distribution
// Copyright (C) 2020, European Space Agency
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

#ifndef C_MODULE_H
#define C_MODULE_H

#include <stdint.h>

// Add 2 16-bit numbers, should consume 2 input registers
int16_t int16Add(const int16_t a, const int16_t b);

// Add 2 32-bit numbers, should consume all 4 input registers
int32_t int32Add(const int32_t a, const int32_t b);

// Add 2 32-bit numbers, should consume all 4 input registers
float floatAdd(const float a, const float b);

// Add int 32 and float, to make sure that the argument order is correct
float addInt32AndFloat(const int32_t i, const float f);

// Add int 16 and float, to make sure that the argument order and alignment is correct
float addInt16AndFloat(const int16_t i, const float f);

// Add 4 32-bit numbers, should be passed through stack
int32_t addMany(const int32_t a1, const int32_t a2, const int32_t a3, const int32_t a4);

#endif
