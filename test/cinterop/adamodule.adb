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

with reporting;

package body AdaModule is

-- Functions to be imported from C module
function int16Add(a : int16_t; b : int16_t) return int16_t;
pragma Import(C, int16Add, "int16Add");
function int32Add(a : int32_t; b : int32_t) return int32_t;
pragma Import(C, int32Add, "int32Add");
function floatAdd(a : Float; b : Float) return Float;
pragma Import(C, floatAdd, "floatAdd");
function addInt32AndFloat(i : int32_t; f : Float) return Float;
pragma Import(C, addInt32AndFloat, "addInt32AndFloat");
function addInt16AndFloat(i : int16_t; f : Float) return Float;
pragma Import(C, addInt16AndFloat, "addInt16AndFloat");
function addMany(a1 : int32_t; a2 : int32_t; a3 : int32_t; a4 : int32_t) return int32_t;
pragma Import(C, addMany, "addMany");

    function test_int16Add return Boolean is
        a : int16_t := 12;
        b : int16_t := 1600;
        r : int16_t;
    begin
        r := int16Add(a, b);
        if r = 1612 then
            return True;
        else
            return False;
        end if;
    end test_int16Add;

    function test_int32Add return Boolean is
        a : int32_t := 1200016;
        b : int32_t := 1600012;
        r : int32_t;
    begin
        r := int32Add(a, b);
        if r = 2800028 then
            return True;
        else
            return False;
        end if;
    end test_int32Add;

    function test_floatAdd return Boolean is
        a : Float := 12.5;
        b : Float := 100.25;
        r : Float;
    begin
        r := floatAdd(a, b);
        if r = 112.75 then
            return True;
        else
            return False;
        end if;
    end test_floatAdd;

    function test_addInt32AndFloat return Boolean is
        i : int32_t := 12;
        f : Float := 100.5;
        r : Float;
    begin
        r := addInt32AndFloat(i, f);
        if r = 112.5 then
            return True;
        else
            return False;
        end if;
    end test_addInt32AndFloat;

    function test_addInt16AndFloat return Boolean is
        i : int16_t := 12;
        f : Float := 100.5;
        r : Float;
    begin
        r := addInt16AndFloat(i, f);
        if r = 112.5 then
            return True;
        else
            return False;
        end if;
    end test_addInt16AndFloat;

    function test_addMany return Boolean is
        a1 : int32_t := 100;
        a2 : int32_t := 200;
        a3 : int32_t := 300;
        a4 : int32_t := 400;
        r : int32_t;
    begin
        r := addMany(a1, a2, a3, a4);
        if r = 1000 then
            return True;
        else
            return False;
        end if;
    end test_addMany;

end AdaModule;
