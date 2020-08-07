with Interfaces;
use Interfaces;

package adaasn1rtl.encoding with Spark_Mode is

   


   type Asn1Int_ARRAY_0_9 is array (0 .. 9) of Asn1UInt;
   Powers_of_10 : constant Asn1Int_ARRAY_0_9 := Asn1Int_ARRAY_0_9'(0 => 1, 1 => 10, 2 => 100, 3 => 1000, 4 => 10000, 5 => 100000, 6 => 1000000, 7 => 10000000, 8 => 100000000, 9 => 1000000000);

   
   
   subtype BIT_RANGE is Natural range 0 .. 7;
   
   
   subtype OctetBuffer_16 is OctetBuffer (1 .. 16);
   subtype OctetArray4 is OctetBuffer (1 .. 4);
   subtype OctetArray8 is OctetBuffer (1 .. 8);
   
   subtype OctetBuffer_0_7 is OctetBuffer (BIT_RANGE);

   subtype Digits_Buffer is OctetBuffer (1 .. 20);
   
   type Bitstream  (Size_In_Bytes:Positive) is record
      Buffer           : OctetBuffer(1 .. Size_In_Bytes) ; 
      Current_Bit_Pos  : Natural;  --current bit for writing or reading in the bitsteam
      pushDataPrm : Integer := 0;
      fetchDataPrm : Integer := 0;
      
   end record;
   
   type BitstreamPtr  is record
      Size_In_Bytes    :   Positive;
      Current_Bit_Pos  : Natural;  --current bit for writing or reading in the bitsteam
      pushDataPrm : Integer := 0;
      fetchDataPrm : Integer := 0;
   end record;

   
   function RequiresReverse  return Boolean;
   function Long_Float_to_Float (x : Asn1Real) return Float;

   function To_UInt (IntVal : Asn1Int) return Asn1UInt;
   
   --function To_Int (IntVal : Asn1UInt) return Asn1Int;
   function To_Int (IntVal : Asn1UInt) return Asn1Int is
   (
      if IntVal > Asn1UInt (Asn1Int'Last) then
          -Asn1Int (not IntVal) - 1 
      else
       Asn1Int (IntVal) );
   
   function abs_value(intVal: Asn1Int) return Asn1UInt is
     (
      if intVal >= 0  then Asn1Uint(intVal) else (Asn1Uint(-(intVal+1))+1)
     );

   
   -- In some cases, SPARK cannot prove the following function
   -- This seems to be a bug since the function is proved if comment
   -- some irrelevant code e.g. the getStringSize function
     
   function To_Int_n (IntVal : Asn1UInt; nBits : Integer) return Asn1Int
   is (
       if IntVal > Asn1UInt(Shift_Left(Asn1UInt(1), nBits - 1) - 1) then  -- is given value greater than the maximum pos value in nBits space?
          --Asn1Int ( ((not (Shift_Left(Asn1UInt(1), nBits) - 1)) or IntVal)) -- in this case the number is negative ==> prefix with 1111 
          -Asn1Int ( not( (not (Shift_Left(Asn1UInt(1), nBits) - 1)) or IntVal)) - 1 -- in this case the number is negative ==> prefix with 1111 
       else
          Asn1Int (IntVal)
      )
     with 
       Pre => nBits > 0 and nBits < Asn1UInt'Size;
   
   
   function Sub (A : in Asn1Int; B : in Asn1Int) return Asn1UInt with
     Pre  => A >= B;
   
   function stringContainsChar (str : String; ch : Character) return Boolean with
      Pre => str'Last < Natural'Last;
   
   function GetBytes (V : Asn1UInt) return Asn1Byte with
     Post    => GetBytes'Result >=1 and GetBytes'Result<=8;
   
   function GetLengthInBytesOfSInt (V : Asn1Int) return Asn1Byte with
     Post    => GetLengthInBytesOfSInt'Result >=1 and GetLengthInBytesOfSInt'Result<=8;
   
     
   function Get_number_of_digits (Int_value : Asn1UInt) return Integer 
   is (
      if Int_value < Powers_of_10(1) then 1
      elsif Int_value >= Powers_of_10(1) and Int_value < Powers_of_10(2)    then 2 
      elsif Int_value >= Powers_of_10(2) and Int_value < Powers_of_10(3)    then 3 
      elsif Int_value >= Powers_of_10(3) and Int_value < Powers_of_10(4)    then 4 
      elsif Int_value >= Powers_of_10(4) and Int_value < Powers_of_10(5)    then 5 
      elsif Int_value >= Powers_of_10(5) and Int_value < Powers_of_10(6)    then 6 
      elsif Int_value >= Powers_of_10(6) and Int_value < Powers_of_10(7)    then 7 
      elsif Int_value >= Powers_of_10(7) and Int_value < Powers_of_10(8)    then 8 
      elsif Int_value >= Powers_of_10(8) and Int_value < Powers_of_10(9)    then 9       
      else 10 )
      ;   
   
   
   
   function PLUS_INFINITY return Asn1Real;
   function MINUS_INFINITY return Asn1Real;

   function GetExponent (V : Asn1Real) return Asn1Int;
   function GetMantissa (V : Asn1Real) return Asn1UInt;
   function RequiresReverse (dummy : Boolean) return Boolean;
   
   
   
   
   
   function milbus_encode (IntVal : in Asn1Int) return Asn1Int 
   is ( if IntVal = 32 then 0  else IntVal);

   function milbus_decode (IntVal : in Asn1Int) return Asn1Int 
   is (if IntVal = 0 then 32   else IntVal);
   
   
   
   --Bit strean functions
   
   function BitStream_init (Bitstream_Size_In_Bytes : Positive) return Bitstream  with
     Pre     => Bitstream_Size_In_Bytes < Positive'Last/8,
     Post    => BitStream_init'Result.Current_Bit_Pos = 0 and BitStream_init'Result.Size_In_Bytes = Bitstream_Size_In_Bytes;

   function BitStream_current_length_in_bytes (bs : in BitStream) return Natural 
   is
        ((bs.Current_Bit_Pos + 7)/8)
        ;

   
   procedure BitStream_AppendBit (bs : in out BitStream; Bit_Value : in BIT) with
     Depends => (bs => (bs, Bit_Value)),
     Pre     => bs.Current_Bit_Pos < Natural'Last and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos < bs.Size_In_Bytes * 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 1;
   
   --BitStream_ReadBit
   procedure BitStream_ReadBit (bs : in out BitStream; Bit_Value : out BIT; result :    out Boolean) with
     Depends => (bs => (bs), Bit_Value => bs, result => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last and then  
                bs.Size_In_Bytes < Positive'Last/8 and then
                bs.Current_Bit_Pos < bs.Size_In_Bytes * 8,
     Post    => result  and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 1;
   
   procedure BitStream_AppendByte (bs : in out BitStream; Byte_Value : in Asn1Byte; Negate : in Boolean) with
     Depends => (bs => (bs, Byte_Value, Negate)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8;
   
   
   procedure BitStream_DecodeByte (bs : in out BitStream; Byte_Value : out Asn1Byte; success   :    out Boolean) with
     Depends => (bs => (bs), Byte_Value => bs, success => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 8,
     Post    => success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 8;
   
   function BitStream_PeekByte(bs : in Bitstream; offset : Natural) return Asn1Byte   with
     Pre     => bs.Current_Bit_Pos   < Natural'Last - offset - 8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos  <= bs.Size_In_Bytes * 8 - offset - 8;
   
   
   procedure BitStream_AppendBits(bs : in out BitStream; bitMaskAsByteArray : in OctetBuffer; bits_to_write : in Natural ) with
     Depends => (bs => (bs, bitMaskAsByteArray, bits_to_write)),
     Pre     => bitMaskAsByteArray'First >= 0 and then
                bitMaskAsByteArray'Last < Natural'Last/8 and then
                bits_to_write >= (bitMaskAsByteArray'Length - 1) * 8 and then
                bits_to_write <= (bitMaskAsByteArray'Length) * 8 and then
                bs.Current_Bit_Pos < Natural'Last - bits_to_write and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - bits_to_write,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + bits_to_write;
   
   procedure  BitStream_ReadBits   (bs : in out BitStream; bitMaskAsByteArray : in out OctetBuffer; bits_to_read : in Natural; success : out boolean) with   
    Depends => ( (bs, bitMaskAsByteArray, success) => (bs, bits_to_read)),
     Pre     => bitMaskAsByteArray'First >= 0 and then
                bitMaskAsByteArray'Last < Natural'Last/8 and then
                bits_to_read >= (bitMaskAsByteArray'Length - 1) * 8 and then
                bits_to_read <= (bitMaskAsByteArray'Length) * 8 and then
                bs.Current_Bit_Pos < Natural'Last - bits_to_read and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - bits_to_read,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + bits_to_read;
     
   procedure  BitStream_SkipBits   (bs : in out BitStream; bits_to_skip : in Natural) with
    Depends => ( (bs) => (bs, bits_to_skip)),
     Pre     => 
                bs.Current_Bit_Pos < Natural'Last - bits_to_skip,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + bits_to_skip;
   
   
   procedure BitStream_ReadNibble (bs : in out BitStream; Byte_Value : out Asn1Byte; success   :    out Boolean) with
     Depends => (bs => (bs), Byte_Value => bs, success => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - 4 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - 4,
     Post    => success and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + 4;
     
   
   procedure BitStream_AppendPartialByte(bs : in out BitStream; Byte_Value : in Asn1Byte; nBits : in BIT_RANGE; negate : in Boolean) with
     Depends => (bs => (bs, Byte_Value, negate, nBits)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;
     
   procedure BitStream_ReadPartialByte(bs : in out BitStream; Byte_Value : out Asn1Byte; nBits : in BIT_RANGE)  with
     Depends => ((bs,Byte_Value) => (bs, nBits) ),
     Pre     => bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;   
     
   function BitStream_PeekPartialByte(bs : in BitStream; offset : Natural; nBits : in BIT_RANGE) return Asn1Byte with
     Pre     => bs.Current_Bit_Pos < Natural'Last - nBits - offset and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits - offset;  
   
   procedure BitStream_Encode_Non_Negative_Integer(bs : in out BitStream; intValue   : in Asn1UInt; nBits : in Integer) with
     Depends => (bs => (bs, intValue, nBits)),
     Pre     => nBits >= 0 and then 
                nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;
   
   procedure BitStream_Decode_Non_Negative_Integer (bs : in out BitStream; IntValue : out Asn1UInt; nBits : in Integer;  result : out Boolean) with
     Depends => ((bs,IntValue, result) => (bs, nBits)),
     Pre     => nBits >= 0 and then 
                nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => result and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;
   
   procedure Enc_UInt (bs : in out BitStream;  intValue : in     Asn1UInt;  total_bytes : in     Integer) with
     Depends => (bs => (bs, intValue, total_bytes)),
     Pre     => total_bytes >= 0 and then 
                total_bytes <= Asn1UInt'Size/8 and then 
                bs.Current_Bit_Pos < Natural'Last - total_bytes*8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - total_bytes*8,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + total_bytes*8;
   
   

   procedure Dec_UInt (bs : in out BitStream; total_bytes : Integer; Ret: out Asn1UInt; Result :    out Boolean)  with
     Depends => (Ret => (bs,total_bytes), Result => (bs,total_bytes),  bs => (bs, total_bytes)),
     Pre     => total_bytes >= 0 and then 
                total_bytes <= Asn1UInt'Size/8 and then 
                bs.Current_Bit_Pos < Natural'Last - total_bytes*8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - total_bytes*8,
     Post    => Result and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + total_bytes*8
                and Ret >= 0 and Ret < 256**total_bytes;

   
   procedure Dec_Int (bs : in out BitStream; total_bytes : Integer; int_value: out Asn1Int; Result :    out Boolean)  with
     Depends => (int_value => (bs,total_bytes), Result => (bs,total_bytes),  bs => (bs, total_bytes)),
     Pre     => total_bytes >= 0 and then 
                total_bytes <= Asn1UInt'Size/8 and then 
                bs.Current_Bit_Pos < Natural'Last - total_bytes*8 and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - total_bytes*8,
     Post    => Result and bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + total_bytes*8;

    pragma Inline (BitStream_AppendByte);
   

   
   procedure Enc_SemiConstraintWholeNumber (bs : in out BitStream; IntVal : in Asn1Int; MinVal : in     Asn1Int) with
     Depends => (bs => (bs, IntVal, MinVal)),
     Pre     => IntVal >= MinVal and then
                bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8);
   
   procedure Dec_SemiConstraintWholeNumber (bs : in out BitStream; IntVal : out Asn1Int; MinVal : in  Asn1Int;  Result :    out Boolean) with
      Depends => ((IntVal, Result) => (bs, MinVal), bs => (bs, MinVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8) and IntVal >= MinVal ;
   
   procedure Enc_SemiConstraintPosWholeNumber (bs : in out BitStream; IntVal : in Asn1UInt; MinVal : in     Asn1UInt) with
     Depends => (bs => (bs, IntVal, MinVal)),
     Pre     => IntVal >= MinVal and then
                bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8);  
   
   procedure Dec_SemiConstraintPosWholeNumber (bs : in out BitStream; IntVal : out Asn1UInt; MinVal : in     Asn1UInt; Result :    out Boolean)  with
     Depends => ((IntVal, Result) => (bs, MinVal), bs => (bs, MinVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8) and IntVal >= MinVal ;   
   
   procedure Enc_UnConstraintWholeNumber (bs : in out BitStream; IntVal : in Asn1Int)  with
     Depends => (bs => (bs, IntVal)),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8);  


   procedure Dec_UnConstraintWholeNumber (bs : in out BitStream; IntVal :    out Asn1Int; Result :    out Boolean) with
     Depends => ((IntVal, bs, Result) => bs),
     Pre     => bs.Current_Bit_Pos < Natural'Last - (Asn1UInt'Size + 8) and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - (Asn1UInt'Size + 8),
     Post    => bs.Current_Bit_Pos >= bs'Old.Current_Bit_Pos and bs.Current_Bit_Pos <= bs'Old.Current_Bit_Pos + (Asn1UInt'Size + 8);  
   
   
   procedure Enc_ConstraintWholeNumber (bs : in out BitStream; IntVal : in Asn1Int; MinVal : in Asn1Int; nBits : in Integer) with
     Depends => (bs => (bs, IntVal, MinVal, nBits)),
     Pre     => IntVal >= MinVal and then
                nBits >= 0 and then nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;
   
   procedure Enc_ConstraintPosWholeNumber (bs : in out BitStream; IntVal: in Asn1UInt; MinVal : in Asn1UInt; nBits : in Integer) with
     Depends => (bs => (bs, IntVal, MinVal, nBits)),
     Pre     => IntVal >= MinVal and then
                nBits >= 0 and then nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits;
   
   procedure Dec_ConstraintWholeNumber (bs : in out BitStream; IntVal : out Asn1Int; MinVal : in Asn1Int; MaxVal : in Asn1Int; nBits : in Integer; Result : out Boolean) with
     Depends => ((bs, IntVal, Result) => (bs, MinVal, MaxVal, nBits)),
     Pre     => MinVal <= MaxVal and then
                nBits >= 0 and then nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits and
                (
                     (Result   and  (((IntVal >= MinVal) and (IntVal <= MaxVal)))) or
                     (not Result  and  (IntVal = MinVal))
                );
   
   procedure Dec_ConstraintPosWholeNumber (bs : in out BitStream; IntVal : out Asn1UInt; MinVal : in Asn1UInt; MaxVal : in Asn1UInt; nBits : in Integer; Result : out Boolean) with
     Depends => ((bs, IntVal, Result) => (bs, MinVal, MaxVal, nBits)),
     Pre     => MinVal <= MaxVal and then
                nBits >= 0 and then nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits and
                (
                     (Result   and  (((IntVal >= MinVal) and (IntVal <= MaxVal)))) or
                     (not Result  and  (IntVal = MinVal))
                );
   
      procedure Dec_ConstraintWholeNumberInt
     (bs : in out BitStream;
      IntVal      :    out Integer;
      MinVal      : in     Integer;
      MaxVal      : in     Integer;
      nBits : in     Integer;
      Result      :    out Boolean) with
     Depends => ((bs, IntVal, Result) => (bs, MinVal, MaxVal, nBits)),
     Pre     => MinVal <= MaxVal and then
                nBits >= 0 and then nBits < Asn1UInt'Size and then 
                bs.Current_Bit_Pos < Natural'Last - nBits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos <= bs.Size_In_Bytes * 8 - nBits,
     Post    => bs.Current_Bit_Pos = bs'Old.Current_Bit_Pos + nBits and
                (
                     (Result   and  (((IntVal >= MinVal) and (IntVal <= MaxVal)))) or
                     (not Result  and  (IntVal = MinVal))
                );

    function BitStream_bitPatternMatches (bs : in BitStream; bit_terminated_pattern : in OctetBuffer; bit_terminated_pattern_size_in_bits : natural) return boolean with
     Pre     => 
                bit_terminated_pattern'First >= 0 and then
                bit_terminated_pattern'Last < Natural'Last/8 and then
                bit_terminated_pattern_size_in_bits <= (bit_terminated_pattern'Length) * 8 and then     
                bs.Current_Bit_Pos   < Natural'Last - bit_terminated_pattern_size_in_bits and then  
                bs.Size_In_Bytes < Positive'Last/8 and  then
                bs.Current_Bit_Pos  <= bs.Size_In_Bytes * 8 - bit_terminated_pattern_size_in_bits;

    procedure bitstrean_fetch_data_if_required(bs : in out BitStream);
    procedure bitstrean_push_data_if_required(bs : in out BitStream);

   
end adaasn1rtl.encoding;
