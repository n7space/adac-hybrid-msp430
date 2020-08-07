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

with BitstreamBase;
use BitstreamBase;

with BitstreamIntegers;
use BitstreamIntegers;

with Interfaces;
use Interfaces;

with uper_asn1_rtl;
use uper_asn1_rtl;

with adaasn1rtl;
use adaasn1rtl;

with cpu;
use cpu;

with utils;
use utils;

procedure Main with Spark_Mode is

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
        null;
    end Failure;

    procedure Success is
    begin
        null;
    end Success;

    function test_BaseRtl return Boolean is
        BIT_SIZE : constant Integer := 16;

        bs : BitStream := BitStream_init(16);
        bitValueIn : BIT := 1;
        byteValueIn : Asn1Byte := 7;
        intValueIn : Asn1UInt := 17;

        bitValueOut : BIT;
        byteValueOut : Asn1Byte;
        intValueOut : Asn1UInt;

        result1 : Boolean;
        result2 : Boolean;
        result3 : Boolean;
    begin
          BitStream_AppendBit(bs, bitValueIn);
          BitStream_AppendByte(bs, byteValueIn, False);
          BitStream_Encode_Non_Negative_Integer(bs, intValueIn, BIT_SIZE);

          bs.Current_Bit_Pos := 0;

          BitStream_ReadBit(bs, bitValueOut, result1);
          BitStream_DecodeByte(bs, byteValueOut, result2);
          BitStream_Decode_Non_Negative_Integer(bs, intValueOut, BIT_SIZE, result3);

          if not result1 then
            Failure(1);
            return False;
          end if;

          if not result2 then
            Failure(2);
            return False;
          end if;

          if not result3 then
            Failure(3);
            return False;
          end if;

          if bitValueOut /= bitValueIn then
            Failure(4);
            return False;
          end if;

          if byteValueOut /= byteValueIn then
            Failure(5);
            return False;
          end if;

          if intValueOut /= intValueIn then
            Failure(6);
            return False;
          end if;
        return True;
    end test_BaseRtl;

    function test_UperRtl return Boolean is
        MIN_VALUE : constant Asn1Int := 12;
        MAX_VALUE : constant Asn1Int := 20;
        BIT_SIZE : constant Integer := 16;

        bs : BitStream := BitStream_init(16);

        intValueIn : Asn1Int := 17;
        floatValueIn : Asn1Real := 3.14;

        intValueOut : Asn1Int;
        floatValueOut : Asn1Real;


        result1 : Boolean;
        result2 : ASN1_RESULT;
    begin
          UPER_Enc_ConstraintWholeNumber(bs, intValueIn, MIN_VALUE, BIT_SIZE);
          UPER_Enc_Real(bs, floatValueIn);

          bs.Current_Bit_Pos := 0;

          UPER_Dec_ConstraintWholeNumber(bs, intValueOut, MIN_VALUE, MAX_VALUE, BIT_SIZE, result1);
          UPER_Dec_Real(bs, floatValueOut, result2);

          if not result1 then
            Failure(11);
            return False;
          end if;

          if not result2.Success then
            Failure(12);
            return False;
          end if;

          if intValueOut /= intValueIn then
            Failure(13);
            return False;
          end if;

          if floatValueOut /= floatValueIn then
            Failure(14);
            return False;
          end if;
          return True;
    end test_UperRtl;

begin
    SetupHardware;
    if test_BaseRtl and test_UperRtl then
      Success;
    end if;
end Main;
