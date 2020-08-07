------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                       S Y S T E M . F A T _ G E N                        --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2019, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  This generic package provides a target independent implementation of the
--  floating-point attributes that denote functions. The implementations here
--  are portable, but very slow. The runtime contains a set of instantiations
--  of this package for all predefined floating-point types, and these should
--  be replaced by efficient assembly language code where possible.


package System.Fat_Flt is

package Attr_Float is   

   subtype UI is Integer;
   --  The runtime representation of universal integer for the purposes of
   --  this package is integer. The expander generates conversions for the
   --  actual type used. For functions returning universal integer, there
   --  is no problem, since the result always is in range of integer. For
   --  input arguments, the expander has to do some special casing to deal
   --  with the (very annoying) cases of out of range values. If we used
   --  Long_Long_Integer to represent universal, then there would be no
   --  problem, but the resulting inefficiency would be annoying.

   function Adjacent          (X, Towards : Float)              return Float;

   function Ceiling           (X : Float)                       return Float;

   function Compose           (Fraction : Float; Exponent : UI) return Float;

   function Copy_Sign         (Value, Sign : Float)             return Float;

   function Exponent          (X : Float)                       return UI;

   function Floor             (X : Float)                       return Float;

   function Fraction          (X : Float)                       return Float;

   function Leading_Part      (X : Float; Radix_Digits : UI)    return Float;

   function Machine           (X : Float)                       return Float;

   function Machine_Rounding  (X : Float)                       return Float;

   function Model             (X : Float)                       return Float;

   function Pred              (X : Float)                       return Float;

   function Remainder         (X, Y : Float)                    return Float;

   function Rounding          (X : Float)                       return Float;

   function Scaling           (X : Float; Adjustment : UI)      return Float;

   function Succ              (X : Float)                       return Float;

   function Truncation        (X : Float)                       return Float;

   function Unbiased_Rounding (X : Float)                       return Float;

   function Valid (X : not null access Float) return Boolean;
   --  This function checks if the object of type T referenced by X is valid,
   --  and returns True/False accordingly. The parameter is passed by reference
   --  (access) here, as the object of type T may be an abnormal value that
   --  cannot be passed in a floating-point register, and the whole point of
   --  'Valid is to prevent exceptions. Note that the object of type T must
   --  have the natural alignment for type T.

   type S is new String (1 .. Float'Size / Character'Size);
   type P is access all S with Storage_Size => 0;
   --  Buffer and access types used to initialize temporaries for validity
   --  checks, if the value to be checked has reverse scalar storage order, or
   --  is not known to be properly aligned (for example it appears in a packed
   --  record). In this case, we cannot call Valid since Valid assumes proper
   --  full alignment. Instead, we copy the value to a temporary location using
   --  type S (we cannot simply do a copy of a T value, because the value might
   --  be invalid, in which case it might not be possible to copy it through a
   --  floating point register).

private
   pragma Inline (Machine);
   pragma Inline (Model);

   --  Note: previously the validity checking subprograms (Unaligned_Valid and
   --  Valid) were also inlined, but this was changed since there were some
   --  problems with this inlining in optimized mode, and in any case it seems
   --  better to avoid this inlining (space and robustness considerations).

end Attr_Float;

end System.Fat_Flt;
