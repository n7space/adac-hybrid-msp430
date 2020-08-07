with Ada.Characters.Latin_1;
with Interfaces;
use Interfaces;

package BitstreamBase with Spark_Mode is

   ERR_END_OF_STREAM        : constant Integer := 1001;
   ERR_INSUFFICIENT_DATA          : constant Integer := 101;
   ERR_UNSUPPORTED_ENCODING : constant Integer := 1002;  --  Returned when the uPER encoding for REALs is not binary encoding
   ERR_INCORRECT_STREAM           : constant Integer := 104;

   NUL : constant Standard.Character := Ada.Characters.Latin_1.NUL;

   --basic asn1scc type definitions
   type BIT is mod 2**1;

   type BitArray is array (Natural range <>) of BIT;
   for BitArray'Component_Size use 1;
   --pragma Pack (BitArray);

   subtype Asn1Byte is Interfaces.Unsigned_8;

   subtype Asn1Int is Interfaces.Integer_32;
   subtype Asn1UInt is Interfaces.Unsigned_32;
   subtype Asn1Real is Standard.Float;

   subtype Asn1Boolean is Boolean;
   subtype Asn1NullType is Interfaces.Unsigned_8;

   subtype BIT_RANGE is Natural range 0 .. 7;


   type OctetBuffer is array (Natural range <>) of Asn1Byte;
   subtype OctetBuffer_16 is OctetBuffer (1 .. 16);
   subtype OctetArray4 is OctetBuffer (1 .. 4);
   subtype OctetArray8 is OctetBuffer (1 .. 8);

   subtype OctetBuffer_0_7 is OctetBuffer (BIT_RANGE);

   subtype Digits_Buffer is OctetBuffer (1 .. 20);

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

   type Bitstream  (Size_In_Bytes:Positive) is record
      Buffer           : OctetBuffer(1 .. Size_In_Bytes) ;
      Current_Bit_Pos  : Natural;  --current bit for writing or reading in the bitsteam
   end record;

   type BitstreamPtr  is record
      Size_In_Bytes    :   Positive;
      Current_Bit_Pos  : Natural;  --current bit for writing or reading in the bitsteam
   end record;

   function BitStream_init (Bitstream_Size_In_Bytes : Positive) return Bitstream  with
     Pre     => Bitstream_Size_In_Bytes < Positive'Last/8,
     Post    => BitStream_init'Result.Current_Bit_Pos = 0 and BitStream_init'Result.Size_In_Bytes = Bitstream_Size_In_Bytes;

end BitstreamBase;