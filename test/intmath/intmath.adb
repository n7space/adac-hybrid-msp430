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

    -- Signed Integer 64

    procedure TestAddInt64(a1 : int64_t; a2 : int64_t; e : int64_t) is
        r : int64_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddInt64;

    procedure TestSubInt64(a1 : int64_t; a2 : int64_t; e : int64_t) is
        r : int64_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubInt64;

    procedure TestMulInt64(m1 : int64_t; m2 : int64_t; e : int64_t) is
        r : int64_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulInt64;

    procedure TestDivInt64(a1 : int64_t; a2 : int64_t; e : int64_t) is
        r : int64_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivInt64;

    -- Unsigned Integer 64

    procedure TestAddUInt64(a1 : uint64_t; a2 : uint64_t; e : uint64_t) is
        r : uint64_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddUInt64;

    procedure TestSubUInt64(a1 : uint64_t; a2 : uint64_t; e : uint64_t) is
        r : uint64_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubUInt64;

    procedure TestMulUInt64(m1 : uint64_t; m2 : uint64_t; e : uint64_t) is
        r : uint64_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulUInt64;

    procedure TestDivUInt64(a1 : uint64_t; a2 : uint64_t; e : uint64_t) is
        r : uint64_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivUInt64;

    -- Signed Integer 32

    procedure TestAddInt32(a1 : int32_t; a2 : int32_t; e : int32_t) is
        r : int32_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddInt32;

    procedure TestSubInt32(a1 : int32_t; a2 : int32_t; e : int32_t) is
        r : int32_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubInt32;

    procedure TestMulInt32(m1 : int32_t; m2 : int32_t; e : int32_t) is
        r : int32_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulInt32;

    procedure TestDivInt32(a1 : int32_t; a2 : int32_t; e : int32_t) is
        r : int32_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivInt32;

    -- Unsigned Integer 32

    procedure TestAddUInt32(a1 : uint32_t; a2 : uint32_t; e : uint32_t) is
        r : uint32_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddUInt32;

    procedure TestSubUInt32(a1 : uint32_t; a2 : uint32_t; e : uint32_t) is
        r : uint32_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubUInt32;

    procedure TestMulUInt32(m1 : uint32_t; m2 : uint32_t; e : uint32_t) is
        r : uint32_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulUInt32;

    procedure TestDivUInt32(a1 : uint32_t; a2 : uint32_t; e : uint32_t) is
        r : uint32_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivUInt32;

    -- Signed Integer 16

    procedure TestAddInt16(a1 : int16_t; a2 : int16_t; e : int16_t) is
        r : int16_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddInt16;

    procedure TestSubInt16(a1 : int16_t; a2 : int16_t; e : int16_t) is
        r : int16_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubInt16;

    procedure TestMulInt16(m1 : int16_t; m2 : int16_t; e : int16_t) is
        r : int16_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulInt16;

    procedure TestDivInt16(a1 : int16_t; a2 : int16_t; e : int16_t) is
        r : int16_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivInt16;

    -- Unsigned Integer 16

    procedure TestAddUInt16(a1 : uint16_t; a2 : uint16_t; e : uint16_t) is
        r : uint16_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddUInt16;

    procedure TestSubUInt16(a1 : uint16_t; a2 : uint16_t; e : uint16_t) is
        r : uint16_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubUInt16;

    procedure TestMulUInt16(m1 : uint16_t; m2 : uint16_t; e : uint16_t) is
        r : uint16_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulUInt16;

    procedure TestDivUInt16(a1 : uint16_t; a2 : uint16_t; e : uint16_t) is
        r : uint16_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivUInt16;

    -- Signed Integer 8

    procedure TestAddInt8(a1 : int8_t; a2 : int8_t; e : int8_t) is
        r : int8_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddInt8;

    procedure TestSubInt8(a1 : int8_t; a2 : int8_t; e : int8_t) is
        r : int8_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubInt8;

    procedure TestMulInt8(m1 : int8_t; m2 : int8_t; e : int8_t) is
        r : int8_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulInt8;

    procedure TestDivInt8(a1 : int8_t; a2 : int8_t; e : int8_t) is
        r : int8_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivInt8;

    -- Unsigned Integer 8

    procedure TestAddUInt8(a1 : uint8_t; a2 : uint8_t; e : uint8_t) is
        r : uint8_t;
    begin
        r := a1 + a2;
        if r /= e then
            Failure(0);
        end if;
    end TestAddUInt8;

    procedure TestSubUInt8(a1 : uint8_t; a2 : uint8_t; e : uint8_t) is
        r : uint8_t;
    begin
        r := a1 - a2;
        if r /= e then
            Failure(0);
        end if;
    end TestSubUInt8;

    procedure TestMulUInt8(m1 : uint8_t; m2 : uint8_t; e : uint8_t) is
        r : uint8_t;
    begin
        r := m1 * m2;
        if r /= e then
            Failure(0);
        end if;
    end TestMulUInt8;

    procedure TestDivUInt8(a1 : uint8_t; a2 : uint8_t; e : uint8_t) is
        r : uint8_t;
    begin
        r := a1 / a2;
        if r /= e then
            Failure(0);
        end if;
    end TestDivUInt8;

-- The purpose of these functions is to break compiler optimizations
-- (otherwise operations are broken into shifts and ands, instead of
-- runtime library calls)

function GetNumberInt64(i : Interfaces.Integer_64) return int64_t is
begin
    return int64_t(i);
end GetNumberInt64;

function GetNumberUInt64(i : Interfaces.Integer_64) return uint64_t is
begin
    return uint64_t(i);
end GetNumberUInt64;

function GetNumberInt32(i : Integer) return int32_t is
begin
    return int32_t(i);
end GetNumberInt32;

function GetNumberUInt32(i : Integer) return uint32_t is
begin
    return uint32_t(i);
end GetNumberUInt32;

function GetNumberInt16(i : Integer) return int16_t is
begin
    return int16_t(i);
end GetNumberInt16;

function GetNumberUInt16(i : Integer) return uint16_t is
begin
    return uint16_t(i);
end GetNumberUInt16;

function GetNumberInt8(i : Integer) return int8_t is
begin
    return int8_t(i);
end GetNumberInt8;

function GetNumberUInt8(i : Integer) return uint8_t is
begin
    return uint8_t(i);
end GetNumberUInt8;

begin
    SetupHardware;

    -- Signed Integer 64
    TestAddInt64(GetNumberInt64(2000000300000),
                  GetNumberInt64(2000000300000),
                  GetNumberInt64(4000000600000));
    TestSubInt64(GetNumberInt64(5000000600000),
                  GetNumberInt64(3000000100000),
                  GetNumberInt64(2000000500000));
    TestMulInt64(GetNumberInt64(2000000),
                  GetNumberInt64(4000000),
                  GetNumberInt64(8000000000000));
    TestDivInt64(GetNumberInt64(6000000000000),
                  GetNumberInt64(2000000),
                  GetNumberInt64(3000000));
    TestDivInt64(GetNumberInt64(-6000000000000),
                 GetNumberInt64(-2000000),
                  GetNumberInt64(3000000));
    TestDivInt64(GetNumberInt64(-6000000000000),
                  GetNumberInt64(2000000),
                 GetNumberInt64(-3000000));
    TestDivInt64(GetNumberInt64(6000000000000),
                GetNumberInt64(-2000000),
                GetNumberInt64(-3000000));
    -- Unsigned Integer 64
    TestAddUInt64(GetNumberUInt64(2000000300000),
                  GetNumberUInt64(2000000300000),
                  GetNumberUInt64(4000000600000));
    TestSubUInt64(GetNumberUInt64(5000000600000),
                  GetNumberUInt64(3000000100000),
                  GetNumberUInt64(2000000500000));
    TestMulUInt64(GetNumberUInt64(2000000),
                  GetNumberUInt64(4000000),
                  GetNumberUInt64(8000000000000));
    TestDivUInt64(GetNumberUInt64(6000000000000),
                  GetNumberUInt64(2000000),
                  GetNumberUInt64(3000000));
    -- Signed Integer 32
    TestAddInt32(GetNumberInt32(2000000),
                 GetNumberInt32(3000000),
                 GetNumberInt32(5000000));
    TestSubInt32(GetNumberInt32(8000000),
                 GetNumberInt32(5000000),
                 GetNumberInt32(3000000));
    TestMulInt32(GetNumberInt32(20000),
                 GetNumberInt32(30000),
                 GetNumberInt32(600000000));
    TestDivInt32(GetNumberInt32(70),    GetNumberInt32(20),  GetNumberInt32(3));
    TestDivInt32(GetNumberInt32(-100),  GetNumberInt32(20),  GetNumberInt32(-5));
    TestDivInt32(GetNumberInt32(-100),  GetNumberInt32(-40), GetNumberInt32(2));
    TestDivInt32(GetNumberInt32(10000000),
                 GetNumberInt32(-30000),
                 GetNumberInt32(-333));
    -- Unsigned Integer 32
    TestAddUInt32(GetNumberUInt32(22),   GetNumberUInt32(33), GetNumberUInt32(55));
    TestSubUInt32(GetNumberUInt32(170),  GetNumberUInt32(50), GetNumberUInt32(120));
    TestMulUInt32(GetNumberUInt32(5),    GetNumberUInt32(7),  GetNumberUInt32(35));
    TestDivUInt32(GetNumberUInt32(7000), GetNumberUInt32(20), GetNumberUInt32(350));
    -- Signed Integer 16
    TestAddInt16(GetNumberInt16(2000),  GetNumberInt16(3000), GetNumberInt16(5000));
    TestSubInt16(GetNumberInt16(6000),  GetNumberInt16(1000), GetNumberInt16(5000));
    TestMulInt16(GetNumberInt16(100),   GetNumberInt16(200),  GetNumberInt16(20000));
    TestDivInt16(GetNumberInt16(70),    GetNumberInt16(20),   GetNumberInt16(3));
    TestDivInt16(GetNumberInt16(-100),  GetNumberInt16(20),   GetNumberInt16(-5));
    TestDivInt16(GetNumberInt16(-100),  GetNumberInt16(-40),  GetNumberInt16(2));
    TestDivInt16(GetNumberInt16(10000), GetNumberInt16(-30),  GetNumberInt16(-333));
    -- Unsigned Integer 16
    TestAddUInt16(GetNumberUInt16(22),   GetNumberUInt16(33), GetNumberUInt16(55));
    TestSubUInt16(GetNumberUInt16(170),  GetNumberUInt16(50), GetNumberUInt16(120));
    TestMulUInt16(GetNumberUInt16(55),   GetNumberUInt16(66), GetNumberUInt16(3630));
    TestDivUInt16(GetNumberUInt16(7000), GetNumberUInt16(20), GetNumberUInt16(350));
    -- Signed Integer 8
    TestAddInt8(GetNumberInt8(22),   GetNumberInt8(33),  GetNumberInt8(55));
    TestSubInt8(GetNumberInt8(120),  GetNumberInt8(50),  GetNumberInt8(70));
    TestMulInt8(GetNumberInt8(5),    GetNumberInt8(7),   GetNumberInt8(35));
    TestDivInt8(GetNumberInt8(70),   GetNumberInt8(20),  GetNumberInt8(3));
    TestDivInt8(GetNumberInt8(-100), GetNumberInt8(20),  GetNumberInt8(-5));
    TestDivInt8(GetNumberInt8(-100), GetNumberInt8(-40), GetNumberInt8(2));
    TestDivInt8(GetNumberInt8(100),  GetNumberInt8(-30), GetNumberInt8(-3));
    -- Unsigned Integer 8
    TestAddUInt8(GetNumberUInt8(22), GetNumberUInt8(33), GetNumberUInt8(55));
    TestSubUInt8(GetNumberUInt8(170),GetNumberUInt8(50), GetNumberUInt8(120));
    TestMulUInt8(GetNumberUInt8(11), GetNumberUInt8(17), GetNumberUInt8(187));
    TestDivUInt8(GetNumberUInt8(91), GetNumberUInt8(7),  GetNumberUInt8(13));

    if NoFailure then
        Success;
    end if;

    loop
        null;
    end loop;
end Main;
