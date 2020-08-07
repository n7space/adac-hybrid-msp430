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

with utils;
use utils;
with usci;

procedure Main is

    procedure ToArray(dataOut : out uint8_array_t; dataIn : in String) is
    begin
        for i in dataIn'Range loop
            dataOut(i) := uint8_t(Character'Pos(dataIn(i)));
        end loop;
    end ToArray;

    helloString : constant String := "Hello!";
    echoString : constant String := "Echo:";
    buffer : uint8_array_t(1..Integer(usci.size_t'Last));
    size : usci.size_t;
begin
      usci.a0.uart.init;

      ToArray(buffer, helloString);
      usci.a0.uart.writeArray(buffer(helloString'First..helloString'Last));
      ToArray(buffer, echoString);
      usci.a0.uart.writeArray(buffer(echoString'First..echoString'Last));

      usci.a0.uart.readArray(buffer, size, usci.size_t(buffer'Last), Character'Pos(';'));
      usci.a0.uart.writeArray(buffer(1..Integer(size)));

      loop
        null;
      end loop;
end Main;
