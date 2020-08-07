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

with Interfaces;
use Interfaces;

with utils;
use utils;

with cpu;
use cpu;

procedure Main is

    EPSILON : constant Float := 0.001;
    NoFailure : Boolean := True;

    procedure SetupHardware is
      tempPm5ctl0 : uint16_t;
    begin
      WDTCTL := WDTPW or WDTHOLD;
      tempPm5ctl0 := PM5CTL0;
      PM5CTL0 := tempPm5ctl0 and not LOCKLPM5;
    end SetupHardware;

    -- Hooks for debugger
    procedure Failure(no : Integer) is
    begin
        NoFailure := False;
    end Failure;

    procedure Success is
    begin
        null;
    end Success;

    procedure FailIfNotEqualFloat(value : Float; reference : Float) is
    begin
        if value > reference + EPSILON then
            Failure(0);
        end if;
        if value < reference - EPSILON then
            Failure(0);
        end if;
    end FailIfNotEqualFloat;

    procedure FailIfNotEqualDouble(value : Long_Float; reference : Long_Float) is
    begin
        if value > reference + Long_Float(EPSILON) then
            Failure(0);
        end if;
        if value < reference - Long_Float(EPSILON) then
            Failure(0);
        end if;
    end FailIfNotEqualDouble;

    -- Float

    procedure TestAddFloat(a1 : Float; a2 : Float; e : Float) is
        r : Float;
    begin
        r := a1 + a2;
        FailIfNotEqualFloat(r, e);
    end TestAddFloat;

    procedure TestSubFloat(a1 : Float; a2 : Float; e : Float) is
        r : Float;
    begin
        r := a1 - a2;
        FailIfNotEqualFloat(r, e);
    end TestSubFloat;

    procedure TestMulFloat(a1 : Float; a2 : Float; e : Float) is
        r : Float;
    begin
        r := a1 * a2;
        FailIfNotEqualFloat(r, e);
    end TestMulFloat;

    procedure TestDivFloat(a1 : Float; a2 : Float; e : Float) is
        r : Float;
    begin
        r := a1 / a2;
        FailIfNotEqualFloat(r, e);
    end TestDivFloat;

    -- Double (Long_Float)

    procedure TestAddDouble(a1 : Long_Float; a2 : Long_Float; e : Long_Float) is
        r : Long_Float;
    begin
        r := a1 + a2;
        FailIfNotEqualDouble(r, e);
    end TestAddDouble;

    procedure TestSubDouble(a1 : Long_Float; a2 : Long_Float; e : Long_Float) is
        r : Long_Float;
    begin
        r := a1 - a2;
        FailIfNotEqualDouble(r, e);
    end TestSubDouble;

    procedure TestMulDouble(a1 : Long_Float; a2 : Long_Float; e : Long_Float) is
        r : Long_Float;
    begin
        r := a1 * a2;
        FailIfNotEqualDouble(r, e);
    end TestMulDouble;

    procedure TestDivDouble(a1 : Long_Float; a2 : Long_Float; e : Long_Float) is
        r : Long_Float;
    begin
        r := a1 / a2;
        FailIfNotEqualDouble(r, e);
    end TestDivDouble;

-- The purpose of these functions is to break compiler optimizations

function GetFloat(f : Float) return Float is
begin
    return f;
end GetFloat;

function GetDouble(f : Long_Float) return Long_Float is
begin
    return f;
end GetDouble;

procedure TestCmpFloat is
begin
    if GetFloat(100.5) > GetFloat(5000.3) then
        Failure(0);
    end if;
    if GetFloat(12.0) < GetFloat(8.0) then
        Failure(0);
    end if;
    if GetFloat(9.0) /= GetFloat(9.0) then
        Failure(0);
    end if;
    if GetFloat(12.0) = GetFloat(9.0) then
        Failure(0);
    end if;
end TestCmpFloat;

procedure TestCmpDouble is
begin
    if GetDouble(100.5) > GetDouble(5000.3) then
        Failure(0);
    end if;
    if GetDouble(12.0) < GetDouble(8.0) then
        Failure(0);
    end if;
    if GetDouble(9.0) /= GetDouble(9.0) then
        Failure(0);
    end if;
    if GetDouble(12.0) = GetDouble(9.0) then
        Failure(0);
    end if;
end TestCmpDouble;

procedure TestFloatConversions is
begin
    if int32_t(GetFloat(14.0)) /= 14 then
        Failure(0);
    end if;
    if int32_t(GetFloat(-1969.0)) /= -1969 then
        Failure(0);
    end if;
    if Float(12) /= GetFloat(12.0) then
        Failure(0);
    end if;
end TestFloatConversions;

procedure TestDoubleConversions is
begin
    if int32_t(GetFloat(14.0)) /= 14 then
        Failure(0);
    end if;
    if int32_t(GetDouble(-1969.0)) /= -1969 then
        Failure(0);
    end if;
    if Long_Float(12) /= GetDouble(12.0) then
        Failure(0);
    end if;
end TestDoubleConversions;

begin
    SetupHardware;

    -- Float
    TestCmpFloat;
    TestFloatConversions;
    TestAddFloat(GetFloat(100.5),
                GetFloat(5000.3),
                GetFloat(5100.8));
    TestSubFloat(GetFloat(1020.40),
                 GetFloat(2030.50),
                GetFloat(-1010.1));
    TestMulFloat(GetFloat(2000.15),
                 GetFloat(3000.30),
                 GetFloat(6001050.045));
    TestDivFloat(GetFloat(500.0),
                 GetFloat(4.0),
                 GetFloat(125.0));
    TestDivFloat(GetFloat(-500.0),
                  GetFloat(4.0),
                 GetFloat(-125.0));
    TestDivFloat(GetFloat(500.0),
                GetFloat(-4.0),
                GetFloat(-125.0));
    TestDivFloat(GetFloat(-500.0),
                 GetFloat(-4.0),
                  GetFloat(125.0));
    -- Double
    TestCmpDouble;
    TestDoubleConversions;
    TestAddDouble(GetDouble(100.5),
                GetDouble(5000.3),
                GetDouble(5100.8));
    TestSubDouble(GetDouble(1020.40),
                 GetDouble(2030.50),
                GetDouble(-1010.1));
    TestMulDouble(GetDouble(2000.15),
                 GetDouble(3000.30),
                 GetDouble(6001050.045));
    TestDivDouble(GetDouble(500.0),
                  GetDouble(4.0),
                  GetDouble(125.0));
    TestDivDouble(GetDouble(-500.0),
                   GetDouble(4.0),
                  GetDouble(-125.0));
    TestDivDouble(GetDouble(500.0),
                 GetDouble(-4.0),
                 GetDouble(-125.0));
    TestDivDouble(GetDouble(-500.0),
                  GetDouble(-4.0),
                   GetDouble(125.0));

    if NoFailure then
        Success;
    end if;

    loop
        null;
    end loop;
end Main;
