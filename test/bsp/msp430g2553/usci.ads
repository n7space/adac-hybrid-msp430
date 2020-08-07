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

package usci is

    type size_t is Range 0..16;

    package a0 is

        SOFTWARE_RESET_ENABLE : constant uint8_t := 16#01#;

        ControlRegister0     : aliased uint8_t with volatile, address => System'To_Address(16#0060#);
        ControlRegister1     : aliased uint8_t with volatile, address => System'To_Address(16#0061#);
        ReceptionBuffer      : aliased uint8_t with volatile, address => System'To_Address(16#0066#);
        TransmissionBuffer   : aliased uint8_t with volatile, address => System'To_Address(16#0067#);

        package uart is
            procedure Init;
            procedure Write(data : in uint8_t);
            procedure WriteArray(data : in uint8_array_t);
            function Read return uint8_t;
            procedure ReadArray(data : in out uint8_array_t; size : out size_t; maxSize : in size_t; terminator : in uint8_t);
        end uart;

    end a0;

end usci;
