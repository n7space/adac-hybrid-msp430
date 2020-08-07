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
with dio;
use dio;

procedure Main is

    procedure Init is
    begin
        port1.DirectionRegister := port1.DirectionRegister or BIT_0 or BIT_2;
    end Init;

    procedure ToggleLed(bit : uint8_t) is
    begin
        port1.OutputRegister := bit;
    end ToggleLed;

begin
      Init;
      ToggleLed(0);
      ToggleLed(1);
      ToggleLed(0);
      ToggleLed(5);
      ToggleLed(0);
      ToggleLed(4);
      ToggleLed(0);
      loop
        null;
      end loop;
end Main;
