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

package AdaModule is

function addInt32(a : int32_t; b : int32_t) return int32_t;
pragma Export(C, addInt32, "addInt32");
function addInt16(a : int16_t; b : int16_t) return int16_t;
pragma Export(C, addInt16, "addInt16");
function addFloat(a : Float; b : Float) return Float;
pragma Export(C, addFloat, "addFloat");
function addInt16AndFloat(i : int16_t; f : Float) return Float;
pragma Export(C, addInt16AndFloat, "addInt16AndFloat");
function addMany(a1 : int32_t; a2 : int32_t; a3 : int32_t; a4 : int32_t) return int32_t;
pragma Export(C, addMany, "addMany");

end AdaModule;
