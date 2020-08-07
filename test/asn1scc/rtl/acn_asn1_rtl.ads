with Interfaces;
use Interfaces;
with adaasn1rtl;
use adaasn1rtl;

with BitstreamBase;
use BitstreamBase;

with BitstreamIntegers;
use BitstreamIntegers;


package acn_asn1_rtl with Spark_Mode is

   procedure Acn_Enc_Int_PositiveInteger_ConstSize(bs : in out BitStream;  IntVal : in     Asn1UInt;   sizeInBits   : in     Integer) with
     Depends => (bs => (bs, IntVal, sizeInBits)),
     Pre     => sizeInBits >= 0 and then
                sizeInBits < Asn1UInt'Size and then
                IntVal <= 2**sizeInBits - 1 and then
                bs.Current_Bit_Pos < Natural'Last - sizeInBits and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - sizeInBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + sizeInBits     ;


   procedure Acn_Enc_Int_PositiveInteger_ConstSize_8(bs : in out BitStream; IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 8 and then
                IntVal <= Asn1UInt(Asn1Byte'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_big_endian_16 (bs : in out BitStream; IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                IntVal <= Asn1UInt(Interfaces.Unsigned_16'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_big_endian_32 (bs : in out BitStream;  IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                IntVal <= Asn1UInt(Interfaces.Unsigned_32'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_big_endian_64 (bs : in out BitStream;   IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_little_endian_16 (bs : in out BitStream; IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                IntVal <= Asn1UInt(Interfaces.Unsigned_16'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_little_endian_32 (bs : in out BitStream;  IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                IntVal <= Asn1UInt(Interfaces.Unsigned_32'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32;

   procedure Acn_Enc_Int_PositiveInteger_ConstSize_little_endian_64 (bs : in out BitStream;   IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64;

   procedure Acn_Enc_Int_PositiveInteger_VarSize_LengthEmbedded  (bs : in out BitStream;  IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8);


   type Asn1Int_ARRAY_2_32 is array (2 .. 32) of Asn1Int;

   PV  : constant Asn1Int_ARRAY_2_32 := Asn1Int_ARRAY_2_32'(2 => Asn1Int(1), 3 => Asn1Int(3), 4 => Asn1Int(7), 5 => Asn1Int(15), 6 => Asn1Int(31), 7 => Asn1Int(63), 8 => Asn1Int(127), 9 => Asn1Int(255), 10 => Asn1Int(511), 11 => Asn1Int(1023), 12 => Asn1Int(2047), 13 => Asn1Int(4095), 14 => Asn1Int(8191), 15 => Asn1Int(16383), 16 => Asn1Int(32767), 17 => Asn1Int(65535), 18 => Asn1Int(131071), 19 => Asn1Int(262143), 20 => Asn1Int(524287), 21 => Asn1Int(1048575), 22 => Asn1Int(2097151), 23 => Asn1Int(4194303), 24 => Asn1Int(8388607), 25 => Asn1Int(16777215), 26 => Asn1Int(33554431), 27 => Asn1Int(67108863), 28 => Asn1Int(134217727), 29 => Asn1Int(268435455), 30 => Asn1Int(536870911), 31 => Asn1Int(1073741823), 32 => Asn1Int(2147483647));
   NV  : constant Asn1Int_ARRAY_2_32 := Asn1Int_ARRAY_2_32'(2 => Asn1Int(-2), 3 => Asn1Int(-4), 4 => Asn1Int(-8), 5 => Asn1Int(-16), 6 => Asn1Int(-32), 7 => Asn1Int(-64), 8 => Asn1Int(-128), 9 => Asn1Int(-256), 10 => Asn1Int(-512), 11 => Asn1Int(-1024), 12 => Asn1Int(-2048), 13 => Asn1Int(-4096), 14 => Asn1Int(-8192), 15 => Asn1Int(-16384), 16 => Asn1Int(-32768), 17 => Asn1Int(-65536), 18 => Asn1Int(-131072), 19 => Asn1Int(-262144), 20 => Asn1Int(-524288), 21 => Asn1Int(-1048576), 22 => Asn1Int(-2097152), 23 => Asn1Int(-4194304), 24 => Asn1Int(-8388608), 25 => Asn1Int(-16777216), 26 => Asn1Int(-33554432), 27 => Asn1Int(-67108864), 28 => Asn1Int(-134217728), 29 => Asn1Int(-268435456), 30 => Asn1Int(-536870912), 31 => Asn1Int(-1073741824), 32 => Asn1Int(-2147483648));

   procedure Acn_Enc_Int_TwosComplement_ConstSize(bs : in out BitStream;  IntVal : in Asn1Int;   sizeInBits   : in     Natural) with
     Depends => (bs => (bs, IntVal, sizeInBits)),
     Pre     => sizeInBits >= 2 and then
                sizeInBits < Asn1UInt'Size and then
                IntVal >= NV(sizeInBits) and then
                IntVal <=  PV(sizeInBits) and then
                bs.Current_Bit_Pos < Natural'Last - sizeInBits and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - sizeInBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + sizeInBits     ;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_8(bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal >= NV(8) and then
                IntVal <=  PV(8) and then
                bs.Current_Bit_Pos < Natural'Last - 8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8     ;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_big_endian_16(bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal >= NV(16) and then
                IntVal <=  PV(16) and then
                bs.Current_Bit_Pos < Natural'Last - 8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16     ;


   procedure Acn_Enc_Int_TwosComplement_ConstSize_big_endian_32(bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal >= NV(32) and then
                IntVal <=  PV(32) and then
                bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32     ;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_big_endian_64(bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64     ;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_little_endian_16 (bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                IntVal <= Asn1Int(Interfaces.Unsigned_16'Last) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_little_endian_32 (bs : in out BitStream;  IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32;

   procedure Acn_Enc_Int_TwosComplement_ConstSize_little_endian_64 (bs : in out BitStream;   IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64;

   procedure Acn_Enc_Int_TwosComplement_VarSize_LengthEmbedded  (bs : in out BitStream;  IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1Int'Size + 8) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1Int'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1Int'Size + 8);



   procedure Acn_Enc_Int_BCD_ConstSize (bs : in out BitStream; IntVal : in Asn1UInt; nNibbles : in Integer) with
     Depends => (bs => (bs, IntVal, nNibbles)),
     Pre     => nNibbles >= 1
     and then
                nNibbles <= 19 and then
                IntVal < Powers_of_10(nNibbles) and then
                bs.Current_Bit_Pos < Natural'Last - 4*nNibbles and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4*nNibbles,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 4*nNibbles  ;


   procedure Acn_Enc_Int_BCD_VarSize_NullTerminated (bs : in out BitStream; IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal < Powers_of_10(9) and then
                bs.Current_Bit_Pos < Natural'Last - 4*(19+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4*(19+1),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 4*(19+1)  ;





   procedure Acn_Enc_Int_ASCII_VarSize_LengthEmbedded (bs : in out BitStream; IntVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal > -Asn1Int(Powers_of_10(8)) and then
                Asn1Uint(abs IntVal) < Powers_of_10(8) and then
                bs.Current_Bit_Pos < Natural'Last - 8*(18+1+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(18+1+1),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(18+1+1)  ;



   procedure Acn_Enc_UInt_ASCII_VarSize_LengthEmbedded (bs : in out BitStream;  IntVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal)),
     Pre     => IntVal < Powers_of_10(9) and then
                bs.Current_Bit_Pos < Natural'Last - 8*(19+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(19+1),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(19+1)  ;


   procedure Acn_Enc_Int_ASCII_VarSize_NullTerminated (bs : in out BitStream; IntVal : in Asn1Int; nullChars : in OctetBuffer) with
     Depends => (bs => (bs, IntVal, nullChars)),
     Pre     =>
                nullChars'Length <= 100 and then
                bs.Current_Bit_Pos < Natural'Last - 8*(Get_number_of_digits(abs_value(IntVal))+nullChars'Length+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(Get_number_of_digits(abs_value(IntVal))+nullChars'Length+1),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(Get_number_of_digits(abs_value(IntVal))+nullChars'Length+1)  ;

   procedure Acn_Enc_UInt_ASCII_VarSize_NullTerminated (bs : in out BitStream; IntVal : in Asn1UInt; nullChars : in OctetBuffer)  with
     Depends => (bs => (bs, IntVal, nullChars)),
     Pre     => nullChars'Length <= 100 and then
                bs.Current_Bit_Pos < Natural'Last - 8*(Get_number_of_digits(IntVal) + nullChars'Length ) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(Get_number_of_digits(IntVal) + nullChars'Length),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(Get_number_of_digits(IntVal) + nullChars'Length)  ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize (bs : in out BitStream; IntVal :out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; nSizeInBits : in Integer; Result: out ASN1_RESULT) with
     Pre     => nSizeInBits >= 0 and then
                nSizeInBits < Asn1UInt'Size and then
                bs.Current_Bit_Pos < Natural'Last - nSizeInBits and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nSizeInBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nSizeInBits  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_8 (bs : in out BitStream; IntVal :out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_big_endian_16 (bs : in out BitStream; IntVal :out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_big_endian_32 (bs : in out BitStream; IntVal :out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_big_endian_64 (bs : in out BitStream; IntVal :out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_little_endian_16 (bs : in out BitStream; IntVal: out Asn1UInt; minVal:in Asn1UInt; maxVal : in Asn1UInt; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_little_endian_32 (bs : in out BitStream; IntVal: out Asn1UInt; minVal:in Asn1UInt; maxVal : in Asn1UInt; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_PositiveInteger_ConstSize_little_endian_64 (bs : in out BitStream; IntVal: out Asn1UInt; minVal:in Asn1UInt; maxVal : in Asn1UInt; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;
   procedure Acn_Dec_Int_PositiveInteger_VarSize_LengthEmbedded (bs : in out BitStream; IntVal : out Asn1UInt; minVal : in Asn1UInt; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - (8*8+8) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (8*8+8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (8*8+8)  and
     ( (Result.Success and IntVal >= minVal ) or
       (not Result.Success and IntVal = minVal));


   procedure Acn_Dec_Int_TwosComplement_ConstSize (bs : in out BitStream;  IntVal : out Asn1Int;  minVal : in Asn1Int; maxVal : in Asn1Int; nSizeInBits : in Integer; Result : out ASN1_RESULT) with
     Pre     => nSizeInBits >= 0 and then
                nSizeInBits < Asn1UInt'Size and then
                bs.Current_Bit_Pos < Natural'Last - nSizeInBits and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nSizeInBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nSizeInBits  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;



   procedure Acn_Dec_Int_TwosComplement_ConstSize_8 (bs : in out BitStream; IntVal :out Asn1Int; minVal : in Asn1Int; maxVal : in Asn1Int; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_big_endian_16 (bs : in out BitStream; IntVal :out Asn1Int; minVal : in Asn1Int; maxVal : in Asn1Int; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_big_endian_32 (bs : in out BitStream; IntVal :out Asn1Int; minVal : in Asn1Int; maxVal : in Asn1Int; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_big_endian_64 (bs : in out BitStream; IntVal :out Asn1Int; minVal : in Asn1Int; maxVal : in Asn1Int; Result: out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_little_endian_16 (bs : in out BitStream; IntVal: out Asn1Int; minVal:in Asn1Int; maxVal : in Asn1Int; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 16 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 16,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 16  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_little_endian_32 (bs : in out BitStream; IntVal: out Asn1Int; minVal:in Asn1Int; maxVal : in Asn1Int; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_ConstSize_little_endian_64 (bs : in out BitStream; IntVal: out Asn1Int; minVal:in Asn1Int; maxVal : in Asn1Int; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or
       (not Result.Success and IntVal = minVal))
   ;

   procedure Acn_Dec_Int_TwosComplement_VarSize_LengthEmbedded  (bs : in out BitStream;  IntVal : out Asn1Int; Result : out ASN1_RESULT) with
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1Int'Size + 8) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1Int'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1Int'Size + 8);

   procedure Acn_Dec_Int_BCD_ConstSize (bs : in out BitStream; IntVal: out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; nNibbles : in Integer;  Result : out ASN1_RESULT) with
     Pre     => nNibbles >= 1  and then
                nNibbles <= 19 and then
                minVal <= maxVal and then
                maxVal <= Powers_of_10(nNibbles) - 1 and then
                bs.Current_Bit_Pos < Natural'Last - 4*nNibbles and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4*nNibbles,
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos  and  bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 4*nNibbles  and
               ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or (not Result.Success and IntVal = minVal));

   procedure Acn_Dec_Int_BCD_VarSize_NullTerminated (bs : in out BitStream; IntVal: out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; Result : out ASN1_RESULT) with
     Pre     => minVal <= maxVal and then
                maxVal <= Powers_of_10(9) - 1 and then
                bs.Current_Bit_Pos < Natural'Last - 4*(19+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4*(19+1),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos  and  bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 4*(19+1)  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or (not Result.Success and IntVal = minVal));


   procedure Acn_Enc_Int_ASCII_ConstSize (bs : in out BitStream; IntVal : in     Asn1Int; nChars : in     Integer) with
     Depends => (bs => (bs, IntVal, nChars)),
     Pre     => nChars >=  Get_number_of_digits(abs_value(IntVal)) + 1 and then
                nChars <= 50 and then
                bs.Current_Bit_Pos < Natural'Last - 8*(nChars) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(nChars),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(nChars)  ;

   procedure Acn_Dec_Int_ASCII_ConstSize (bs : in out BitStream; IntVal: out Asn1Int; minVal : in Asn1Int; maxVal : in Asn1Int; nChars : in Integer;  Result : out ASN1_RESULT) with
     Pre     => nChars >= 2 and then nChars <=50 and then
                minVal <= maxVal and then
                bs.Current_Bit_Pos < Natural'Last - 8*(nChars+1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(nChars),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(nChars+1)  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or (not Result.Success and IntVal = minVal));

   procedure Acn_Enc_UInt_ASCII_ConstSize (bs : in out BitStream; IntVal : in     Asn1UInt; nChars : in     Integer) with
     Depends => (bs => (bs, IntVal, nChars)),
     Pre     => nChars >= 1 and then nChars <=19 and then
                IntVal < Powers_of_10(nChars) and then
                bs.Current_Bit_Pos < Natural'Last - 8*(nChars) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(nChars),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(nChars)  ;

   procedure Acn_Dec_UInt_ASCII_ConstSize (bs : in out BitStream; IntVal: out Asn1UInt; minVal : in Asn1UInt; maxVal : in Asn1UInt; nChars : in Integer;  Result : out ASN1_RESULT)   with
     Pre     => nChars >= 2 and then nChars <=19 and then
                minVal <= maxVal and then
                maxVal < Powers_of_10(9) and then
                bs.Current_Bit_Pos < Natural'Last - 8*(nChars) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(nChars),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(nChars)  and
     ( (Result.Success and IntVal >= minVal and IntVal <= maxVal) or (not Result.Success and IntVal = minVal));

   procedure Acn_Dec_UInt_ASCII_VarSize_NullTerminated (bs : in out BitStream; IntVal: out Asn1UInt; nullChars: in OctetBuffer; Result : out ASN1_RESULT)   with
     Pre     => nullChars'Length >= 1 and then
                nullChars'Length <= 10 and then
                nullChars'First = 1 and then
                bs.Current_Bit_Pos < Natural'Last - 8*(20+nullChars'Length) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(20+nullChars'Length),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos  and  bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(20+nullChars'Length)  ;

   procedure Acn_Dec_Int_ASCII_VarSize_NullTerminated (bs : in out BitStream; IntVal: out Asn1Int; nullChars: in OctetBuffer; Result : out ASN1_RESULT) with
     Pre     => nullChars'Length >= 1 and then
                nullChars'Length < 10 and then
                nullChars'First = 1 and then
                bs.Current_Bit_Pos < Natural'Last - 8*(20+1+nullChars'Length) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8*(20+1+nullChars'Length),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos  and  bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + 8*(20+1+nullChars'Length)  ;

   procedure Acn_Enc_Real_IEEE754_32_big_endian (bs : in out BitStream;   RealVal : in     Asn1Real) with
     Depends => (bs => (bs, RealVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32;

   procedure Acn_Dec_Real_IEEE754_32_big_endian (bs : in out BitStream; RealVal : out Asn1Real;  Result  : out ASN1_RESULT) with
     Depends => ((Result,bs, RealVal) => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32 ;

   procedure Acn_Enc_Real_IEEE754_64_big_endian (bs : in out BitStream;   RealVal : in     Asn1Real) with
     Depends => (bs => (bs, RealVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64;

   procedure Acn_Dec_Real_IEEE754_64_big_endian (bs : in out BitStream; RealVal : out Asn1Real;  Result  : out ASN1_RESULT) with
     Depends => ((Result,bs, RealVal) => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64 ;

   procedure Acn_Enc_Real_IEEE754_32_little_endian (bs : in out BitStream;   RealVal : in     Asn1Real) with
     Depends => (bs => (bs, RealVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32;

   procedure Acn_Dec_Real_IEEE754_32_little_endian (bs : in out BitStream; RealVal : out Asn1Real;  Result  : out ASN1_RESULT) with
     Depends => ((Result,bs, RealVal) => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 32 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 32,
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 32 ;

   procedure Acn_Enc_Real_IEEE754_64_little_endian (bs : in out BitStream;   RealVal : in     Asn1Real) with
     Depends => (bs => (bs, RealVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64;

   procedure Acn_Dec_Real_IEEE754_64_little_endian (bs : in out BitStream; RealVal : out Asn1Real;  Result  : out ASN1_RESULT) with
     Depends => ((Result,bs, RealVal) => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 64 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 64,
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 64 ;

   procedure Acn_Enc_Boolean_true_pattern (bs : in out BitStream; BoolVal : in Asn1Boolean; pattern : in     BitArray) with
     Depends => (bs => (bs, BoolVal, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);

   procedure Acn_Dec_Boolean_true_pattern (bs : in out BitStream;  BoolVal :    out Asn1Boolean;  pattern : in     BitArray; Result  :    out ASN1_RESULT) with
     Depends => ( (bs, BoolVal, Result) => (bs, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);

   procedure Acn_Enc_Boolean_false_pattern (bs : in out BitStream; BoolVal : in Asn1Boolean; pattern : in     BitArray) with
     Depends => (bs => (bs, BoolVal, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);

   procedure Acn_Dec_Boolean_false_pattern (bs : in out BitStream;  BoolVal :    out Asn1Boolean;  pattern : in     BitArray; Result  :    out ASN1_RESULT) with
     Depends => ( (bs, BoolVal, Result) => (bs, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);


   procedure Acn_Enc_NullType_pattern (bs : in out BitStream; encVal  : in     Asn1NullType;  pattern : in     BitArray) with
     Depends => (bs => (bs, encVal, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);


   procedure Acn_Dec_NullType_pattern (bs : in out BitStream; decValue :    out Asn1NullType; pattern  : in     BitArray;  Result   :    out ASN1_RESULT) with
     Depends => ( (bs, decValue, Result) => (bs, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);


   procedure Acn_Enc_NullType_pattern2 (bs : in out BitStream; pattern : in     BitArray) with
     Depends => (bs => (bs, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);


   procedure Acn_Dec_NullType_pattern2 (bs : in out BitStream; pattern  : in     BitArray;  Result   :    out ASN1_RESULT) with
     Depends => ( (bs, Result) => (bs, pattern)),
     Pre     => pattern'Last >= pattern'First and then
                pattern'Last - pattern'First < Natural'Last and then
                bs.Current_Bit_Pos < Natural'Last - (pattern'Last - pattern'First + 1) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (pattern'Last - pattern'First + 1),
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (pattern'Last - pattern'First + 1);

   procedure Acn_Enc_NullType(bs : in out BitStream;  encVal : in     Asn1NullType) with
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos;

   procedure Acn_Dec_NullType (bs : in out BitStream; decValue :    out Asn1NullType;   Result   :    out ASN1_RESULT) with
     Post    => Result.Success and decValue = 0 and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos;

   procedure Acn_Enc_String_Ascii_FixSize (bs : in out BitStream; strVal : in String) with
     Depends => (bs => (bs, strVal)),
     Pre     => strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                bs.Current_Bit_Pos < Natural'Last - (strVal'Last - strVal'First)*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (strVal'Last - strVal'First)*8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (strVal'Last - strVal'First)*8;


   procedure Acn_Dec_String_Ascii_FixSize (bs : in out BitStream;  strVal : in out String; Result :    out ASN1_RESULT) with
     Depends => ( (bs, strVal, Result) => (bs)),
     Pre     => strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                bs.Current_Bit_Pos < Natural'Last - (strVal'Last - strVal'First)*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (strVal'Last - strVal'First)*8,
     Post    => Result.Success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + (strVal'Last - strVal'First)*8;

   procedure Acn_Enc_String_Ascii_Null_Teminated (bs : in out BitStream; null_characters : in OctetBuffer;  strVal : in String) with
     Depends => (bs => (bs, strVal, null_characters)),
     Pre     => null_characters'Length >= 1 and then
                null_characters'Length <= 10  and then
                null_characters'First = 1 and then
                strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - null_characters'Length and then
                bs.Current_Bit_Pos < Natural'Last - (strVal'Length + null_characters'Length)*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (strVal'Length + null_characters'Length)*8,
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (strVal'Length + null_characters'Length)*8;


   procedure Acn_Dec_String_Ascii_Null_Teminated (bs : in out BitStream; null_characters : in OctetBuffer; strVal : in out String; Result : out ASN1_RESULT) with
     Depends => ( (bs, strVal, Result) => (bs, null_characters)),
     Pre     => null_characters'Length >= 1 and then
                null_characters'Length <= 10  and then
                null_characters'First = 1 and then
                strVal'Last < Natural'Last and then
                strVal'Last >= strVal'First and then
                strVal'Length  < Natural'Last/8 - null_characters'Length   and then
                bs.Current_Bit_Pos < Natural'Last - (strVal'Length + null_characters'Length)*8 and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (strVal'Length + null_characters'Length)*8,
     Post    => Result.Success and bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (strVal'Length + null_characters'Length)*8;


   procedure Acn_Enc_String_Ascii_Internal_Field_Determinant (bs : in out BitStream; asn1Min : Asn1Int;  nLengthDeterminantSizeInBits : in     Integer; strVal : in     String) with
     Depends => (bs => (bs, asn1Min, strVal, nLengthDeterminantSizeInBits)),
     Pre     => nLengthDeterminantSizeInBits >= 0 and then nLengthDeterminantSizeInBits < Asn1UInt'Size and then
                asn1Min >= 0 and then
                strVal'Last < Natural'Last and then
                strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                asn1Min <= Asn1Int(getStringSize (strVal)) and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits);

   procedure Acn_Dec_String_Ascii_Internal_Field_Determinant (bs : in out BitStream; asn1Min : Asn1Int; asn1Max : Asn1Int; nLengthDeterminantSizeInBits : in Integer; strVal : in out String; Result : out ASN1_RESULT) with
     Depends => ( (bs, strVal, Result) => (bs, asn1Min, asn1Max, nLengthDeterminantSizeInBits)),
     Pre     => asn1Min >= 0 and then
                asn1Max <= Asn1Int(Integer'Last) and then
                asn1Min <= asn1Max and then
                nLengthDeterminantSizeInBits >= 0 and then nLengthDeterminantSizeInBits < Asn1UInt'Size and then
                strVal'Last < Natural'Last and then
                strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*8 + nLengthDeterminantSizeInBits);




   procedure Acn_Enc_String_Ascii_External_Field_Determinant(bs : in out BitStream;  strVal : in     String) with
     Depends => (bs => (bs, strVal)),
     Pre     => strVal'Last < Natural'Last and then
                strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*8 ) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*8 ),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*8);

   procedure Acn_Dec_String_Ascii_External_Field_Determinant (bs : in out BitStream; extSizeDeterminatFld : in Asn1Int; strVal : in out String;  Result : out ASN1_RESULT)  with
     Depends => ( (bs, strVal, Result) => (bs, extSizeDeterminatFld)),
     Pre     => extSizeDeterminatFld >= 0 and then
                extSizeDeterminatFld <= Asn1Int(Integer'Last) and then
                strVal'Last < Natural'Last and then
                strVal'Last >= strVal'First and then
                strVal'Last - strVal'First < Natural'Last/8 - 8 and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*8) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*8);


   procedure Acn_Enc_String_CharIndex_External_Field_Determinant (bs : in out BitStream; charSet : String; nCharSize : Integer;  strVal : in String) with
     Depends => (bs => (bs, strVal, nCharSize, charSet)),
     Pre     => nCharSize >=1 and then nCharSize <= 8 and then
                strVal'Last < Natural'Last and then strVal'Last >= strVal'First and then
                charSet'Last < Natural'Last and then charSet'Last >= charSet'First and then charSet'Last-charSet'First <= 255 and then
                strVal'Last - strVal'First < Natural'Last/8 - nCharSize and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*nCharSize ) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*nCharSize ),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*nCharSize);


   procedure Acn_Dec_String_CharIndex_External_Field_Determinant (bs : in out BitStream; charSet : String; nCharSize :Integer; extSizeDeterminatFld : in Asn1Int; strVal : in out String; Result : out ASN1_RESULT) with
     Depends => ( (bs, strVal, Result) => (bs, extSizeDeterminatFld, charSet, nCharSize)),
     Pre     => extSizeDeterminatFld >= 0 and then        extSizeDeterminatFld <= Asn1Int(Integer'Last) and then
                nCharSize >=1 and then nCharSize <= 8 and then
                strVal'Last < Natural'Last and then       strVal'Last >= strVal'First and then
                charSet'Last < Natural'Last and then charSet'Last >= charSet'First and then charSet'Last-charSet'First <= 255 and then
                strVal'Last - strVal'First < Natural'Last/8 - nCharSize and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*nCharSize) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*nCharSize),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*nCharSize);


   procedure Acn_Enc_String_CharIndex_Internal_Field_Determinant (bs : in out BitStream; charSet : String; nCharSize : Integer; asn1Min : Asn1Int; nLengthDeterminantSizeInBits : in Integer; strVal: in String) with
     Pre     => nLengthDeterminantSizeInBits >= 0 and then nLengthDeterminantSizeInBits < Asn1UInt'Size and then
                asn1Min >= 0 and then
                nCharSize >=1 and then nCharSize <= 8 and then
                strVal'Last < Natural'Last and then strVal'Last >= strVal'First and then
                charSet'Last < Natural'Last and then charSet'Last >= charSet'First and then charSet'Last-charSet'First <= 255 and then
                strVal'Last - strVal'First < Natural'Last/8 - nCharSize and then
                asn1Min <= Asn1Int(getStringSize (strVal)) and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits ),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits);

   procedure Acn_Dec_String_CharIndex_Internal_Field_Determinant (bs : in out BitStream;  charSet : String;  nCharSize : Integer;
                                                                  asn1Min : Asn1Int; asn1Max: Asn1Int; nLengthDeterminantSizeInBits : in Integer; strVal : in out String; Result : out ASN1_RESULT) with
     Pre     => asn1Min >= 0 and then
                asn1Max <= Asn1Int(Integer'Last) and then
                asn1Min <= asn1Max and then
                nLengthDeterminantSizeInBits >= 0 and then nLengthDeterminantSizeInBits < Asn1UInt'Size and then
                nCharSize >=1 and then nCharSize <= 8 and then
                strVal'Last < Natural'Last and then       strVal'Last >= strVal'First and then
                charSet'Last < Natural'Last and then charSet'Last >= charSet'First and then charSet'Last-charSet'First <= 255 and then Asn1Int(charSet'First) + asn1Max < Asn1Int(Integer'Last) and then
                strVal'Last - strVal'First < Natural'Last/8 - nCharSize and then
                bs.Current_Bit_Pos < Natural'Last - ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits) and then
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + ((strVal'Last - strVal'First + 1)*nCharSize + nLengthDeterminantSizeInBits);

end acn_asn1_rtl;
