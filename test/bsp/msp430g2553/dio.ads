-- This file is part of the adac-hybrid-msp430 distribution
-- Copyright (C) 2020, European Space Agency
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

with System;
with utils;
use utils;

package dio is

    BIT_0 : constant uint8_t := 16#01#;
    BIT_1 : constant uint8_t := 16#02#;
    BIT_2 : constant uint8_t := 16#04#;
    BIT_3 : constant uint8_t := 16#08#;
    BIT_4 : constant uint8_t := 16#10#;
    BIT_5 : constant uint8_t := 16#20#;
    BIT_6 : constant uint8_t := 16#40#;
    BIT_7 : constant uint8_t := 16#80#;

    package port1 is


        InputRegister     : aliased uint8_t with volatile, address => System'To_Address(16#0020#);
        OutputRegister    : aliased uint8_t with volatile, address => System'To_Address(16#0021#);
        DirectionRegister : aliased uint8_t with volatile, address => System'To_Address(16#0022#);
        ModeRegister1     : aliased uint8_t with volatile, address => System'To_Address(16#0026#);
        ModeRegister2     : aliased uint8_t with volatile, address => System'To_Address(16#0041#);

    end port1;

end dio;
