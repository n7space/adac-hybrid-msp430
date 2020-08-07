with BitstreamBase;
use BitstreamBase;

with BitstreamIntegers;
use BitstreamIntegers;

package body adaasn1rtl with Spark_Mode is


   MantissaFactor : constant Asn1Real :=  Asn1Real (Interfaces.Unsigned_32 (2)**Asn1Real'Machine_Mantissa);

   function Sub (A : in Asn1Int; B : in Asn1Int) return Asn1UInt
   is
      ret : Asn1UInt;
      au  : Asn1UInt;
      bu  : Asn1UInt;
   begin

      au := To_UInt (A);
      bu := To_UInt (B);

      if au >= bu then
         ret := au - bu;
      else
         ret := bu - au;
         ret := not ret;
         ret := ret + 1;
      end if;

      return ret;
   end Sub;

   function GetBytes (V : Asn1UInt) return Asn1Byte
   is
      Ret : Asn1Byte;
   begin
      if V < 16#100# then
         Ret := 1;
      elsif V < 16#10000# then
         Ret := 2;
      elsif V < 16#1000000# then
         Ret := 3;
      else
         Ret := 4;
      end if;
      return Ret;
   end GetBytes;

   function GetLengthInBytesOfSIntAux (V : Asn1UInt) return Asn1Byte
   is
      Ret : Asn1Byte;
   begin
      if V < 16#80# then
         Ret := 1;
      elsif V < 16#8000# then
         Ret := 2;
      elsif V < 16#800000# then
         Ret := 3;
      else
         Ret := 4;
      end if;

      return Ret;
   end GetLengthInBytesOfSIntAux;

   function GetLengthInBytesOfSInt (V : Asn1Int) return Asn1Byte
   is
      Ret : Asn1Byte;
   begin
      if V >= 0 then
         Ret := GetLengthInBytesOfSIntAux (Asn1UInt (V));
      else
         Ret := GetLengthInBytesOfSIntAux (Asn1UInt (-(V + 1)));
      end if;
      return Ret;
   end GetLengthInBytesOfSInt;


   function getStringSize (str : String) return Integer is
      length : Integer :=0;
   begin
      for i in str'Range loop
         pragma Loop_Invariant (length = length'Loop_Entry + (i - str'First));
         exit when str (I) = Standard.ASCII.NUL;
         length := length + 1;
      end loop;

      return length;
   end getStringSize;




   function GetZeroBasedCharIndex (CharToSearch   :    Character;  AllowedCharSet : in String) return Integer
   is
      ret : Integer;
   begin
      ret := 0;
      for I in Integer range AllowedCharSet'Range loop
         ret := I - AllowedCharSet'First;
         pragma Loop_Invariant  (
            AllowedCharSet'Last >= AllowedCharSet'First and
            AllowedCharSet'Last <= Integer'Last - 1 and
            ret = I - AllowedCharSet'First);
         exit when CharToSearch = AllowedCharSet (I);
      end loop;
      return ret;
   end GetZeroBasedCharIndex;

   function CharacterPos (C : Character) return Integer is
      ret : Integer;
   begin
      ret := Character'Pos (C);
      if not (ret >= 0 and ret <= 127) then
         ret := 0;
      end if;
      return ret;
    end CharacterPos;



   function GetExponent (V : Asn1Real) return Asn1Int is
      pragma SPARK_Mode (Off);
   --due to the fact that Examiner has not yet implement the Exponent attribute
   begin
      return Asn1Int (Asn1Real'Exponent (V) - Asn1Real'Machine_Mantissa);
   end GetExponent;

   function GetMantissa (V : Asn1Real) return Asn1UInt is
      pragma SPARK_Mode (Off);
   --due to the fact that Examiner has not yet implement the Fraction attribute
   begin
      return Asn1UInt (Asn1Real'Fraction (V) * MantissaFactor);
   end GetMantissa;



   function Zero return Asn1Real is
   begin
      return 0.0;
   end Zero;

   function PLUS_INFINITY return Asn1Real is
      pragma SPARK_Mode (Off);
   begin
      return 1.0 / Zero;
   end PLUS_INFINITY;

   function MINUS_INFINITY return Asn1Real is
      pragma SPARK_Mode (Off);
   begin
      return -1.0 / Zero;
   end MINUS_INFINITY;

   function RequiresReverse (dummy : Boolean) return Boolean is
      pragma SPARK_Mode (Off);
      dword : Integer := 16#00000001#;
      arr   : aliased OctetArray4;
      for arr'Address use dword'Address;
   begin
      return arr (arr'First) = 1;
   end RequiresReverse;


   function stringContainsChar (str : String; ch : Character) return Boolean is
      I      : Integer;
      bFound : Boolean := False;
   begin
      I := str'First;
      while I <= str'Last and not bFound loop
         pragma Loop_Invariant (I >= str'First and I <= str'Last);
         bFound := str (I) = ch;
         I      := I + 1;
      end loop;
      return bFound;
   end stringContainsChar;



    procedure ObjectIdentifier_Init(val:out Asn1ObjectIdentifier)
    is
    begin
        val.Length :=0;
        val.values := ObjectIdentifier_array'(others => 0);
    end ObjectIdentifier_Init;


    function ObjectIdentifier_isValid(val : in Asn1ObjectIdentifier) return boolean
    is
    begin
        return val.Length >=2 and then val.values(1)<=2 and then val.values(2)<=39;
    end ObjectIdentifier_isValid;

    function RelativeOID_isValid(val : in Asn1ObjectIdentifier) return boolean
    is
    begin
        return val.Length > 0;
    end RelativeOID_isValid;

    function ObjectIdentifier_equal(val1 : in Asn1ObjectIdentifier; val2 : in Asn1ObjectIdentifier) return boolean
    is
        ret : boolean;
        i : integer;
    begin
        ret := val1.Length = val2.length;
        i := 1;
        while ret and i <= val1.Length loop
            pragma Loop_Invariant(i>=1 and i <= val1.Length and val1.Length = val2.length);
            ret := val1.values(i) = val2.values(i);
            i := i + 1;
        end loop;

        return ret;
    end ObjectIdentifier_equal;








   function RequiresReverse  return Boolean is
      pragma SPARK_Mode (Off);
      dword : Integer := 16#00000001#;
      arr   : aliased OctetArray4;
      for arr'Address use dword'Address;
   begin
      return arr (arr'First) = 1;
   end RequiresReverse;



   function Long_Float_to_Float (x : Asn1Real) return Float is
      pragma SPARK_Mode (Off);
   begin
      return Float (x);
   end Long_Float_to_Float;

end adaasn1rtl;
