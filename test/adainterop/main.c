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

#include <stdint.h>
#include <stdbool.h>

// Reporting functions defined in Ada "Reporting" module
void reporting__init();
void reporting__reportsuccess();
void reporting__reporterror(const int32_t errno);

// Tested functions defined in "AdaModule" module, but exported to C
int32_t addInt32(const int32_t a, const int32_t b);
int16_t addInt16(const int16_t a, const int16_t b);
float addFloat(const float a, const float b);
float addInt16AndFloat(const int16_t i, const float f);
int32_t addMany(const int32_t a1, const int32_t a2, const int32_t a3, const int32_t a4);

static bool test_addInt32()
{
    const int32_t a = 16;
    const int32_t b = 52;
    const int32_t result = addInt32(a, b);
    if (result == (a + b))
        return true;
    return false;
}

static bool test_addInt16()
{
    const int16_t a = 16;
    const int16_t b = 52;
    const int16_t result = addInt16(a, b);
    if (result == (a + b))
        return true;
    return false;
}

static bool test_addFloat()
{
    const float a = 16.5;
    const float b = 52.25;
    const float result = addFloat(a, b);
    if (result == (a + b))
        return true;
    return false;
}

static bool test_addInt16AndFloat()
{
    const int16_t i = 16;
    const float f = 52.25;
    const float result = addFloat(i, f);
    if (result == (i + f))
        return true;
    return false;
}

static bool test_addMany()
{
    const int32_t a1 = 1234;
    const int32_t a2 = 64561;
    const int32_t a3 = 15632;
    const int32_t a4 = 52345;
    const int32_t result = addMany(a1, a2, a3, a4);
    if (result == (a1 + a2 + a3 + a4))
        return true;
    return false;
}

void runTests(void)
{
    reporting__init();
    if (!test_addInt32())
    {
        reporting__reporterror(0);
        return;
    }
    if (!test_addInt16())
    {
        reporting__reporterror(1);
        return;
    }
    if (!test_addFloat())
    {
        reporting__reporterror(2);
        return;
    }
    if (!test_addInt16AndFloat())
    {
        reporting__reporterror(3);
        return;
    }
    if (!test_addMany())
    {
        reporting__reporterror(4);
        return;
    }
    reporting__reportsuccess();
}

int main(void)
{
    runTests();
    for (;;);
    return 0;
}
