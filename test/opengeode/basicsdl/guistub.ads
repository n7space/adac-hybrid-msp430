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

with BASIC_SDL_DATAVIEW;
use BASIC_SDL_DATAVIEW;
with TASTE_BasicTypes;
use TASTE_BasicTypes;

package guistub is

    count : Integer := 0;
    result : aliased asn1SccT_Boolean := False;

    procedure RI�toGui(param1: access asn1SccT_Boolean);
    pragma export(C, RI�toGui, "basicsdl_RI_toGui");

end guistub;
