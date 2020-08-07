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
with Interfaces;
use Interfaces;

package utils is

type uint64_t is mod 2**64;
for uint64_t'size use 64;

type int64_t is new Interfaces.Integer_64 range -9223372036854775808..9223372036854775807;
for int64_t'size use 64;

type uint32_t is mod 4294967295;
for uint32_t'size use 32;

type int32_t is new integer range -2147483648..2147483647;
for int32_t'size use 32;

type uint16_t is mod 65536;
for uint16_t'size use 16;

type int16_t is new integer range -32768..32767;
for int16_t'size use 16;

type uint8_t is mod 256;
for uint8_t'size use 8;

type int8_t is new integer range -128..127;
for int8_t'size use 8;

type uint8_array_t is array(Integer RANGE <>) of uint8_t;

function "or"(left, right : uint16_t) return uint16_t;
function "and"(left, right : uint16_t) return uint16_t;
function "not"(x : uint16_t) return uint16_t;

function "or"(left, right : uint8_t) return uint8_t;
function "and"(left, right : uint8_t) return uint8_t;
function "not"(x : uint8_t) return uint8_t;

procedure StringToArray(dataOut : out uint8_array_t; dataIn : in String);

end utils;
