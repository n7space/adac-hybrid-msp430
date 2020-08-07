with Ada.Characters.Latin_1;
with Interfaces;
use Interfaces;
with BitstreamBase;
use BitstreamBase;

package body BitstreamIntegers is

   MASKS  : constant OctetBuffer_0_7 := OctetBuffer_0_7'(0 => 16#80#, 1=> 16#40#, 2=>16#20#, 3=>16#10#, 4=>16#08#, 5=>16#04#, 6=>16#02#, 7=>16#01#);
   MASKSB : constant OctetBuffer_0_7 := OctetBuffer_0_7'(0 => 16#00#, 1=> 16#01#, 2=>16#03#, 3=>16#07#, 4=>16#0F#, 5=>16#1F#, 6=>16#3F#, 7=>16#7F#);

   procedure BitStream_AppendBit(bs : in out BitStream; Bit_Value : in BIT)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
   begin

         bs.buffer(Current_Byte) :=
           (if Bit_Value = 1 then
               bs.buffer(Current_Byte) or MASKS(Current_Bit)
            else
               bs.buffer(Current_Byte) and (not MASKS(Current_Bit)));

      bs.Current_Bit_Pos := bs.Current_Bit_Pos + 1;

      end;

   procedure BitStream_ReadBit(bs : in out BitStream; Bit_Value : out BIT; result :    out Boolean)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
   begin
      result := bs.Current_Bit_Pos < Natural'Last and bs.Current_Bit_Pos < bs.Size_In_Bytes * 8;

      if (bs.buffer(Current_Byte) and MASKS(Current_Bit)) > 0 then
         Bit_Value := 1;
      else
         Bit_Value := 0;
      end if;

      bs.Current_Bit_Pos := bs.Current_Bit_Pos + 1;
   end;


   procedure BitStream_AppendByte(bs : in out BitStream; Byte_Value : in Asn1Byte; Negate : in Boolean)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      byteVal : Asn1Byte;
      ncb :BIT_RANGE;
   begin
      if Negate then
         byteVal := not Byte_Value;
      else
         byteVal := Byte_Value;
      end if;

      if Current_Bit > 0 then
         ncb := 8 - Current_Bit;
         bs.buffer(Current_Byte) := bs.buffer(Current_Byte) or Shift_right(ByteVal, Current_Bit);
         bs.buffer(Current_Byte+1) := Shift_left(ByteVal, ncb);
      else
         bs.buffer(Current_Byte) := ByteVal;
      end if;
       bs.Current_Bit_Pos := bs.Current_Bit_Pos + 8;
   end;


   procedure BitStream_DecodeByte(bs : in out BitStream; Byte_Value : out Asn1Byte; success   :    out Boolean)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      ncb :BIT_RANGE;
   begin
      success := bs.Current_Bit_Pos < Natural'Last - 8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
        bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8;

      if Current_Bit > 0 then
         ncb := 8 - Current_Bit;
         Byte_Value := Shift_left(bs.buffer(Current_Byte), Current_Bit);
         Byte_Value := Byte_Value or Shift_right(bs.buffer(Current_Byte + 1), ncb);
      else
         Byte_Value := bs.buffer(Current_Byte);
      end if;

      bs.Current_Bit_Pos := bs.Current_Bit_Pos + 8;

   end;

   procedure BitStream_ReadNibble(bs : in out BitStream; Byte_Value : out Asn1Byte; success   :    out Boolean)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      totalBitsForNextByte : BIT_RANGE;
   begin
      success := bs.Current_Bit_Pos < Natural'Last - 4 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
        bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4;

      if Current_Bit < 4 then
         Byte_Value := Shift_right(bs.buffer(Current_Byte), 4 - Current_Bit) and 16#0F#;
      else
         totalBitsForNextByte := Current_Bit - 4;
         Byte_Value := Shift_left(bs.buffer(Current_Byte), totalBitsForNextByte);
         --bs.currentBytePos := bs.currentBytePos + 1;
         if totalBitsForNextByte > 0 then
            Byte_Value := Byte_Value or (Shift_right(bs.buffer(Current_Byte + 1), 8 - totalBitsForNextByte));
         end if;

         Byte_Value := Byte_Value and 16#0F#;
      end if;
      bs.Current_Bit_Pos := bs.Current_Bit_Pos + 4;
   end;


   procedure BitStream_AppendPartialByte(bs : in out BitStream; Byte_Value : in Asn1Byte; nBits : in BIT_RANGE; negate : in Boolean)
   is
      Current_Byte :  Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      cb  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      totalBits : BIT_RANGE;
      totalBitsForNextByte : BIT_RANGE;
      byteValue : Asn1Byte;
   begin
      if nBits > 0 then
         byteValue := (if negate then (masksb(nBits) and  not Byte_Value) else Byte_Value);

         if cb < 8 - nbits then
            totalBits := cb + nBits;
            bs.buffer(Current_Byte) := bs.buffer(Current_Byte) or Shift_left(byteValue, 8 -totalBits);
         else
            totalBitsForNextByte := cb+nbits - 8;
            bs.buffer(Current_Byte) := bs.buffer(Current_Byte) or Shift_right(byteValue, totalBitsForNextByte);
            if totalBitsForNextByte > 0 then
               Current_Byte := Current_Byte + 1;
               bs.buffer(Current_Byte) := bs.buffer(Current_Byte) or Shift_left(byteValue, 8 - totalBitsForNextByte);
            end if;

         end if;
         bs.Current_Bit_Pos := bs.Current_Bit_Pos + nBits;
      end if;


   end;

   procedure BitStream_ReadPartialByte(bs : in out BitStream; Byte_Value : out Asn1Byte; nBits : in BIT_RANGE)
   is
      Current_Byte :  Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      cb  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      totalBits : BIT_RANGE;
      totalBitsForNextByte : BIT_RANGE;
   begin
         if cb < 8 - nbits then
            totalBits := cb + nBits;
            Byte_Value := Shift_Right(bs.buffer(Current_Byte), 8 -totalBits) and MASKSB(nBits);
         else
            totalBitsForNextByte := cb+nbits - 8;
            Byte_Value := Shift_left(bs.buffer(Current_Byte), totalBitsForNextByte);
            if totalBitsForNextByte > 0 then
               Current_Byte := Current_Byte + 1;
               Byte_Value := Byte_Value or Shift_right(bs.buffer(Current_Byte), 8 - totalBitsForNextByte);
            end if;
            Byte_Value := Byte_Value and MASKSB(nBits);
      end if;
      bs.Current_Bit_Pos := bs.Current_Bit_Pos + nBits;
   end;


   procedure BitStream_Encode_Non_Negative_Integer(bs : in out BitStream; intValue   : in Asn1UInt; nBits : in Integer)
   is
      byteValue : Asn1Byte;
      tmp : Asn1UInt;
      total_bytes : constant Integer := nBits/8;
      cc : constant BIT_RANGE := nBits mod 8;
      bits_to_shift :Integer;
   begin
      for i in 1 .. total_bytes loop
         bits_to_shift := (total_bytes- i)*8 + cc;
         tmp := 16#FF# and Shift_right(intValue, bits_to_shift);
         byteValue := Asn1Byte (tmp);

         pragma Loop_Invariant (bs.Current_Bit_Pos = bs.Current_Bit_Pos'Loop_Entry + (i-1)*8);

         BitStream_AppendByte(bs, byteValue, false);
      end loop;

      if cc > 0 then
         byteValue := MASKSB(cc) and Asn1Byte(16#FF# and intValue);
         BitStream_AppendPartialByte(bs, byteValue, cc, False);
      end if;

   end;

   procedure BitStream_Decode_Non_Negative_Integer (bs : in out BitStream; IntValue : out Asn1UInt; nBits : in Integer;  result : out Boolean)
   is
      byteValue : Asn1Byte;
      total_bytes : constant Integer := nBits/8;
      cc : constant BIT_RANGE := nBits mod 8;
   begin
      result :=
                nBits >= 0 and then
                nBits < Asn1UInt'Size and then
                bs.Current_Bit_Pos < Natural'Last - nBits and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits;
      IntValue := 0;

      for i in 1 .. total_bytes loop
         pragma Loop_Invariant (bs.Current_Bit_Pos = bs.Current_Bit_Pos'Loop_Entry + (i-1)*8);

         BitStream_DecodeByte(bs, byteValue, Result);
         IntValue := (IntValue * 256) or Asn1UInt(byteValue);
      end loop;

      if cc > 0 then
         BitStream_ReadPartialByte(bs, byteValue, cc);

         IntValue := Shift_left(IntValue,cc) or Asn1UInt(byteValue);
      end if;

   end BitStream_Decode_Non_Negative_Integer;



   procedure Enc_UInt (bs : in out BitStream;  intValue : in     Asn1UInt;  total_bytes : in Integer)
   is
      byteValue : Asn1Byte;
      tmp : Asn1UInt;
      bits_to_shift :Integer;
   begin

      for i in 1 .. total_bytes loop
         bits_to_shift := (total_bytes- i)*8;
         tmp := 16#FF# and Shift_right(intValue, bits_to_shift);
         byteValue := Asn1Byte (tmp);

         pragma Loop_Invariant (bs.Current_Bit_Pos = bs.Current_Bit_Pos'Loop_Entry + (i-1)*8);

         BitStream_AppendByte(bs, byteValue, false);
      end loop;


   end Enc_UInt;

   procedure Dec_UInt (bs : in out BitStream; total_bytes : Integer; Ret: out Asn1UInt; Result :    out Boolean)
   is
      ByteVal : Asn1Byte;
   begin
      Ret    := 0;
      Result := total_bytes >= 0 and then
                total_bytes <= Asn1UInt'Size/8 and then
                bs.Current_Bit_Pos < Natural'Last - total_bytes*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - total_bytes*8;

      for i in 1 .. total_bytes loop
         pragma Loop_Invariant (bs.Current_Bit_Pos = bs.Current_Bit_Pos'Loop_Entry + (i-1)*8);

         BitStream_DecodeByte(bs, ByteVal, Result);
         Ret := Ret * 256; --shift left one byte
         Ret := Ret + Asn1UInt(ByteVal);

      end loop;

      pragma Assume( Ret < 256**total_bytes);

   end Dec_UInt;



   procedure Dec_Int (bs : in out BitStream; total_bytes : Integer; int_value: out Asn1Int; Result :    out Boolean)
   is
      Current_Byte : constant Integer   := bs.Buffer'First + bs.Current_Bit_Pos / 8;
      Current_Bit  : constant BIT_RANGE := bs.Current_Bit_Pos mod 8;
      ByteVal : Asn1Byte;
      Ret:  Asn1UInt;
   begin
      Result := total_bytes >= 0 and then
                total_bytes <= Asn1UInt'Size/8 and then
                bs.Current_Bit_Pos < Natural'Last - total_bytes*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - total_bytes*8;
      if total_bytes > 0 then
        if (bs.buffer(Current_Byte) and MASKS(Current_Bit)) = 0 then
           Ret := 0;
        else
           Ret := Asn1UInt'Last;
        end if;

        for i in 1 .. total_bytes loop
           pragma Loop_Invariant (bs.Current_Bit_Pos = bs.Current_Bit_Pos'Loop_Entry + (i-1)*8);

           BitStream_DecodeByte(bs, ByteVal, Result);
           Ret := (Ret * 256) or Asn1UInt(ByteVal);

        end loop;
        int_value := To_Int(Ret);
      else
         int_value := 0;
      end if;

   end Dec_Int;

end BitstreamIntegers;