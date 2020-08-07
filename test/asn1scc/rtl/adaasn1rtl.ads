with Ada.Characters.Latin_1;
with Interfaces;
use Interfaces;

with BitstreamBase;
use BitstreamBase;

with BitstreamIntegers;
use BitstreamIntegers;

package adaasn1rtl with Spark_Mode is

   type Asn1Int_ARRAY_0_9 is array (0 .. 9) of Asn1UInt;
   Powers_of_10 : constant Asn1Int_ARRAY_0_9 := Asn1Int_ARRAY_0_9'(0 => 1, 1 => 10, 2 => 100, 3 => 1000, 4 => 10000, 5 => 100000, 6 => 1000000, 7 => 10000000, 8 => 100000000, 9 => 1000000000);


   -- OBJECT IDENTIFIER
   OBJECT_IDENTIFIER_MAX_LENGTH : constant Integer       := 20;        -- the maximum number of components for Object Identifier
   SUBTYPE ObjectIdentifier_length_index is integer range 0..OBJECT_IDENTIFIER_MAX_LENGTH;
   SUBTYPE ObjectIdentifier_index is integer range 1..OBJECT_IDENTIFIER_MAX_LENGTH;
   type ObjectIdentifier_array is array (ObjectIdentifier_index) of Asn1UInt;

   type Asn1ObjectIdentifier is  record
      Length : ObjectIdentifier_length_index;
      values  : ObjectIdentifier_array;
   end record;


   type ASN1_RESULT is record
      Success   : Boolean;
      ErrorCode : Integer;
   end record;


   type TEST_CASE_STEP is
     (TC_VALIDATE, TC_ENCODE, TC_DECODE, TC_VALIDATE_DECODED, TC_EQUAL);

   type TEST_CASE_RESULT is record
      Step      : TEST_CASE_STEP;
      Success   : Boolean;
      ErrorCode : Integer;
   end record;



   function RequiresReverse  return Boolean;
   function Long_Float_to_Float (x : Asn1Real) return Float;

   function OctetString_equal(len1 : in Integer;len2 : in Integer; arr1 : in OctetBuffer; arr2 : in OctetBuffer) return boolean
   is
   (
      len1 = len2 and then arr1(arr1'First .. arr1'First + (len1 - 1)) = arr2(arr2'First .. arr2'First + (len1 - 1))
   )
       with
         Pre => len1 > 0 and len2 > 0 and arr1'First + (len1-1) <= arr1'Last and arr2'First + (len2-1) <= arr1'Last;


   function BitString_equal(len1 : in Integer;len2 : in Integer; arr1 : in BitArray; arr2 : in BitArray) return boolean
   is
   (
      len1 = len2 and then arr1(arr1'First .. arr1'First + (len1 - 1)) = arr2(arr2'First .. arr2'First + (len1 - 1))
   )
       with
         Pre => len1 > 0 and len2 > 0 and arr1'First + (len1-1) <= arr1'Last and arr2'First + (len2-1) <= arr1'Last;

   function Sub (A : in Asn1Int; B : in Asn1Int) return Asn1UInt with
     Pre  => A >= B;

   function stringContainsChar (str : String; ch : Character) return Boolean;

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


   function Asn1Real_Equal (Left, Right : in Asn1Real) return Boolean
   is (
      if Left = Right then True
      elsif Left = 0.0 then Right = 0.0
      elsif Left > Right then   ((Left - Right) / Left) < 0.00001
      else  ((Right - Left) / Left) < 0.00001
   );



   function PLUS_INFINITY return Asn1Real;
   function MINUS_INFINITY return Asn1Real;

   function GetExponent (V : Asn1Real) return Asn1Int;
   function GetMantissa (V : Asn1Real) return Asn1UInt;
   function RequiresReverse (dummy : Boolean) return Boolean;


    procedure ObjectIdentifier_Init(val:out Asn1ObjectIdentifier);
    function ObjectIdentifier_isValid(val : in Asn1ObjectIdentifier) return boolean;
    function RelativeOID_isValid(val : in Asn1ObjectIdentifier) return boolean;
    function ObjectIdentifier_equal(val1 : in Asn1ObjectIdentifier; val2 : in Asn1ObjectIdentifier) return boolean;



   function milbus_encode (IntVal : in Asn1Int) return Asn1Int
   is ( if IntVal = 32 then 0  else IntVal);

   function milbus_decode (IntVal : in Asn1Int) return Asn1Int
   is (if IntVal = 0 then 32   else IntVal);


   function GetZeroBasedCharIndex (CharToSearch   :    Character;   AllowedCharSet : in String) return Integer
     with
      Pre => AllowedCharSet'First <= AllowedCharSet'Last and
      AllowedCharSet'Last <= Integer'Last - 1,
      Post =>
       (GetZeroBasedCharIndex'Result >= 0 and   GetZeroBasedCharIndex'Result <=  AllowedCharSet'Last - AllowedCharSet'First);

   function CharacterPos (C : Character) return Integer with
     Post => (CharacterPos'Result >= 0 and CharacterPos'Result <= 127);

   function getStringSize (str : String) return Integer with
     Pre     => str'Last < Natural'Last and then
                str'Last >= str'First,
     Post => getStringSize'Result >= 0 and getStringSize'Result <= (str'Last - str'First + 1);

   --Bit strean functions



end adaasn1rtl;
