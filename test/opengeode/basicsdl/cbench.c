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

#include <stdlib.h>
#include <stdio.h>

__attribute__ ((constructor)) void cbench___elabb(void)
{
    printf("cbench___elabb\n");
}

int main(int argc, char* argv[])
{
    printf("main\n");
    return 0;
}
