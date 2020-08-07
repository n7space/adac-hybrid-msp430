------------------------------------------------------------------------------
--                                                                          --
--                        GNAT RUN-TIME COMPONENTS                          --
--                                                                          --
--                               S Y S T E M                                --
--                                                                          --
--                                 S p e c                                  --
--                             (MSP430 Version)                             --
--          Copyright (C) 1992-2007 Free Software Foundation, Inc.          --
--                      Copyright (C) 2013 Brian Drummond                   --
--                                                                          --
--                        Derived from AVR-Ada version                      --
--          Copyright (C) 1992-2007 Free Software Foundation, Inc.          --
--                  Copyright (C) 2004, 2010, 2012 Rolf Ebert               --
--                                                                          --
-- This specification is derived from the Ada Reference Manual for use with --
-- GNAT. The copyright notice above, and the license provisions that follow --
-- apply solely to the  contents of the part following the private keyword. --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the  Free Software Foundation,  51  Franklin  Street,  Fifth  Floor, --
-- Boston, MA 02110-1301, USA.                                              --
--                                                                          --
-- As a special exception,  if other files  instantiate  generics from this --
-- unit, or you link  this unit with other files  to produce an executable, --
-- this  unit  does not  by itself cause  the resulting  executable  to  be --
-- covered  by the  GNU  General  Public  License.  This exception does not --
-- however invalidate  any other reasons why  the executable file  might be --
-- covered by the  GNU Public License.                                      --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  these pragmas may alternatively be placed in "gnat.adc"
pragma Restrictions (No_Exception_Propagation);
pragma Restrictions (No_Exception_Registration);
pragma Restrictions (No_Finalization);
pragma Restrictions (No_Implicit_Dynamic_Code);
--  Pointers to nested subprograms are not allowed, in order
--  to prevent the compiler from building "trampolines".

package System is
   pragma Pure;
   --  Note that we take advantage of the implementation permission to make
   --  this unit Pure instead of Preelaborable; see RM 13.7.1(15). In Ada
   --  2005, this is Pure in any case (AI-362).

   type Name is (SYSTEM_NAME_GNAT);
   System_Name : constant Name := SYSTEM_NAME_GNAT;

   --  System-Dependent Named Numbers

   Min_Int               : constant := Long_Long_Integer'First;
   Max_Int               : constant := Long_Long_Integer'Last;

   Max_Binary_Modulus    : constant := 2 ** Long_Long_Integer'Size;
   Max_Nonbinary_Modulus : constant := 2 ** Integer'Size - 1;

   Max_Base_Digits       : constant := Long_Long_Float'Digits;
   Max_Digits            : constant := Long_Long_Float'Digits;

   Max_Mantissa          : constant := 63;
   Fine_Delta            : constant := 2.0 ** (-Max_Mantissa);

   Tick                  : constant := 1.0;

   --  Storage-related Declarations

   Storage_Unit : constant := 8;
   Word_Size    : constant := 16;
   Memory_Size  : constant := 2 ** 16;

   type Address is mod Memory_Size;
   Null_Address : constant Address := 0;

   --  Address comparison

   function "<"  (Left, Right : Address) return Boolean;
   function "<=" (Left, Right : Address) return Boolean;
   function ">"  (Left, Right : Address) return Boolean;
   function ">=" (Left, Right : Address) return Boolean;
   function "="  (Left, Right : Address) return Boolean;

   pragma Import (Intrinsic, "<");
   pragma Import (Intrinsic, "<=");
   pragma Import (Intrinsic, ">");
   pragma Import (Intrinsic, ">=");
   pragma Import (Intrinsic, "=");

   --  Other System-Dependent Declarations

   type Bit_Order is (High_Order_First, Low_Order_First);
   Default_Bit_Order : constant Bit_Order := High_Order_First;
   pragma Warnings (Off, Default_Bit_Order); -- kill constant condition warning

   --  Priority-related Declarations (RM D.1)

   Max_Priority           : constant Positive := 245;
   Max_Interrupt_Priority : constant Positive := 255;

   subtype Any_Priority       is Integer      range   0 .. 255;
   subtype Priority           is Any_Priority range   0 .. 245;
   subtype Interrupt_Priority is Any_Priority range 246 .. 255;

   Default_Priority : constant Priority := 122;

private

   Run_Time_Name : constant String := "MSP430 Zero Footprint Run Time";

   --------------------------------------
   -- System Implementation Parameters --
   --------------------------------------

   --  These parameters provide information about the target that is used
   --  by the compiler. They are in the private part of System, where they
   --  can be accessed using the special circuitry in the Targparm unit
   --  whose source should be consulted for more detailed descriptions
   --  of the individual switch values.

   Backend_Divide_Checks     : constant Boolean := False;
   Backend_Overflow_Checks   : constant Boolean := True;
   Command_Line_Args         : constant Boolean := False;
   --  Set False if no command line arguments on target. Note that if this
   --  is False in with Configurable_Run_Time_On_Target set to True, then
   --  this causes suppression of generation of the argv/argc variables
   --  used to record command line arguments.

   Configurable_Run_Time     : constant Boolean := True;
   --  Indicates that the system.ads file is for a configurable run-time
   --
   --  In configurable run-time mode, the system run-time may not support
   --  the full Ada language. The effect of setting this switch is to let
   --  the compiler know that it is not surprising (i.e. the system is not
   --  misconfigured) if run-time library units or entities within units are
   --  not present in the run-time.
   --
   --  This has some specific effects as follows
   --
   --    The binder generates the gnat_argc/argv/envp variables in the
   --    binder file instead of being imported from the run-time library.
   --    If Command_Line_Args_On_Target is set to False, then the
   --    generation of these variables is suppressed completely.

   Denorm                    : constant Boolean := True;

   Duration_32_Bits          : constant Boolean := True;
   Duration_Delta_Microseconds : constant       := 1000;
   --  If True, then Duration is represented in 32 bits and the delta
   --  and small values are set to Duration_Delta_Microseconds*(10**(-6))
   --  (i.e. for Duration_Delta_Microseconds = 20000 it is a count in
   --  units of 20 milliseconds.
   --  Duration_Delta_Microseconds must be named integer number.

   Exit_Status_Supported     : constant Boolean := False;
   --  Set False if returning of an exit status is not supported on target.
   --  Note that if this False in with Configurable_Run_Time_On_Target
   --  set to True, then this causes suppression of the gnat_exit_status
   --  variable used to record the exit status.

   Fractional_Fixed_Ops      : constant Boolean := False;
   Frontend_Layout           : constant Boolean := False;
   Machine_Overflows         : constant Boolean := False;
   Machine_Rounds            : constant Boolean := True;
   Preallocated_Stacks       : constant Boolean := False;
   Signed_Zeros              : constant Boolean := True;
   Stack_Check_Default       : constant Boolean := False;
   Stack_Check_Probes        : constant Boolean := False;
   Stack_Check_Limits        : constant Boolean := False;
   Support_Aggregates        : constant Boolean := True;
   Support_Composite_Assign  : constant Boolean := True;
   Support_Composite_Compare : constant Boolean := True;
   Support_Long_Shifts       : constant Boolean := True;
   Always_Compatible_Rep     : constant Boolean := True;
   Suppress_Standard_Library : constant Boolean := True;
   --  If this flag is True, then the standard library is not included by
   --  default in the executable (see unit System.Standard_Library in file
   --  s-stalib.ads for details of what this includes). This is for example
   --  set True for the zero foot print case, where these files should not
   --  be included by default.
   --
   --  This flag has some other related effects:
   --
   --    The generation of global variables in the bind file is suppressed,
   --    with the exception of the priority of the environment task, which
   --    is needed by the Ravenscar run-time.
   --
   --    The generation of exception tables is suppressed for front end
   --    ZCX exception handling (since we assume no exception handling).
   --
   --    The calls to __gnat_initialize and __gnat_finalize are omitted
   --
   --    All finalization and initialization (controlled types) is omitted
   --
   --    The routine __gnat_handler_installed is not imported

   Use_Ada_Main_Program_Name : constant Boolean := False;
   ZCX_By_Default            : constant Boolean := False;
   GCC_ZCX_Support           : constant Boolean := False;

end System;
