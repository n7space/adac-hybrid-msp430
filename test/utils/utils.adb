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

package body utils is

type bitarray8 is mod 2**uint8_t'size;
type bitarray16 is mod 2**uint16_t'size;

function "or"(left, right : uint16_t) return uint16_t is
begin
    return uint16_t(bitarray16(left) or bitarray16(right));
end "or";

function "and"(left, right : uint16_t) return uint16_t is
begin
    return uint16_t(bitarray16(left) and bitarray16(right));
end "and";

function "not"(x : uint16_t) return uint16_t is
begin
    return uint16_t(not bitarray16(x));
end "not";

function "or"(left, right : uint8_t) return uint8_t is
begin
    return uint8_t(bitarray8(left) or bitarray8(right));
end "or";

function "and"(left, right : uint8_t) return uint8_t is
begin
    return uint8_t(bitarray8(left) and bitarray8(right));
end "and";

function "not"(x : uint8_t) return uint8_t is
begin
    return uint8_t(not bitarray8(x));
end "not";

procedure StringToArray(dataOut : out uint8_array_t; dataIn : in String) is
begin
    for i in dataIn'Range loop
        dataOut(i) := uint8_t(Character'Pos(dataIn(i)));
    end loop;
end StringToArray;

end utils;
