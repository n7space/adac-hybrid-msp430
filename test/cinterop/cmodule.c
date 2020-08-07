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

#include "cmodule.h"


int16_t int16Add(const int16_t a, const int16_t b)
{
    return a + b;
}

int32_t int32Add(const int32_t a, const int32_t b)
{
    return a + b;
}


float floatAdd(const float a, const float b)
{
    return a + b;
}


float addInt32AndFloat(const int32_t i, const float f)
{
    return ((float)i) + f;
}


float addInt16AndFloat(const int16_t i, const float f)
{
    return ((float)i) + f;
}


int32_t addMany(const int32_t a1, const int32_t a2, const int32_t a3, const int32_t a4)
{
    return a1 + a2 + a3 + a4;
}
