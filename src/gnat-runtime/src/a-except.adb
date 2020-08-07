------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                       A D A . E X C E P T I O N S                        --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--          Copyright (C) 1992-2019, Free Software Foundation, Inc.         --
--          Copyright (C) 2012, Rolf Ebert                                  --
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

package body Ada.Exceptions is

   procedure Reset;
   pragma Import (Ada, Reset);
   for Reset'Address use 0;
   pragma No_Return (Reset);

   procedure Default_Handler (Msg : System.Address; Line : Integer);
   pragma Export (C, Default_Handler, "__gnat_last_chance_handler");
   pragma Weak_External (Default_Handler);
   pragma No_Return (Default_Handler);

   procedure Default_Handler (Msg : System.Address; Line : Integer) is
      pragma Unreferenced (Msg);
      pragma Unreferenced (Line);
   begin
      Reset;
   end Default_Handler;

   procedure Last_Chance_Handler (Msg : System.Address; Line : Integer);
   pragma Import (C, Last_Chance_Handler, "__gnat_last_chance_handler");
   pragma No_Return (Last_Chance_Handler);

   procedure Raise_Exception (E : Exception_Id; Message : String := "") is
      pragma Unreferenced (E);
   begin
      Last_Chance_Handler (Message'Address, 0);
   end Raise_Exception;

   procedure Raise_Exception_No_Defer
     (E       : Exception_Id;
      Message : String := "");
   pragma Export
    (Ada, Raise_Exception_No_Defer,
     "ada__exceptions__raise_exception_no_defer");
   pragma No_Return (Raise_Exception_No_Defer);
   --  Similar to Raise_Exception, but with no abort deferral

   procedure Raise_With_Msg (E : Exception_Id);
   pragma No_Return (Raise_With_Msg);
   pragma Export (C, Raise_With_Msg, "__gnat_raise_with_msg");
   --  Raises an exception with given exception id value. A message
   --  is associated with the raise, and has already been stored in the
   --  exception occurrence referenced by the Current_Excep in the TSD.
   --  Abort is deferred before the raise call.   

   procedure Raise_Constraint_Error (File : System.Address; Line : Integer);
   pragma No_Return (Raise_Constraint_Error);
   pragma Export (C, Raise_Constraint_Error, "__gnat_raise_constraint_error");
   --  Raise constraint error with file:line information

   procedure Raise_Constraint_Error_Msg
     (File   : System.Address;
      Line   : Integer;
      Column : Integer;
      Msg    : System.Address);
   pragma No_Return (Raise_Constraint_Error_Msg);
   pragma Export
     (C, Raise_Constraint_Error_Msg, "__gnat_raise_constraint_error_msg");
   --  Raise constraint error with file:line:col + msg information

   procedure Raise_Program_Error (File : System.Address; Line : Integer);
   pragma No_Return (Raise_Program_Error);
   pragma Export (C, Raise_Program_Error, "__gnat_raise_program_error");
   --  Raise program error with file:line information

   procedure Raise_Program_Error_Msg
     (File : System.Address;
      Line : Integer;
      Msg  : System.Address);
   pragma No_Return (Raise_Program_Error_Msg);
   pragma Export
     (C, Raise_Program_Error_Msg, "__gnat_raise_program_error_msg");
   --  Raise program error with file:line + msg information

   procedure Raise_Storage_Error (File : System.Address; Line : Integer);
   pragma No_Return (Raise_Storage_Error);
   pragma Export (C, Raise_Storage_Error, "__gnat_raise_storage_error");
   --  Raise storage error with file:line information

   procedure Raise_Storage_Error_Msg
     (File : System.Address;
      Line : Integer;
      Msg  : System.Address);
   pragma No_Return (Raise_Storage_Error_Msg);
   pragma Export
     (C, Raise_Storage_Error_Msg, "__gnat_raise_storage_error_msg");
   --  Raise storage error with file:line + reason msg information

   --  The exception raising process and the automatic tracing mechanism rely
   --  on some careful use of flags attached to the exception occurrence. The
   --  graph below illustrates the relations between the Raise_ subprograms
   --  and identifies the points where basic flags such as Exception_Raised
   --  are initialized.

   --  (i) signs indicate the flags initialization points. R stands for Raise,
   --  W for With, and E for Exception.

   --                   R_No_Msg    R_E   R_Pe  R_Ce  R_Se
   --                       |        |     |     |     |
   --                       +--+  +--+     +---+ | +---+
   --                          |  |            | | |
   --     R_E_No_Defer(i)    R_W_Msg(i)       R_W_Loc
   --           |               |              |   |
   --           +------------+  |  +-----------+   +--+
   --                        |  |  |                  |
   --                        |  |  |             Set_E_C_Msg(i)
   --                        |  |  |
   --            Complete_And_Propagate_Occurrence

   --------------------------------
   -- Run-Time Check Subprograms --
   --------------------------------

   --  These subprograms raise a specific exception with a reason message
   --  attached. The parameters are the file name and line number in each
   --  case. The names are defined by Exp_Ch11.Get_RT_Exception_Name.

   procedure Rcheck_CE_Access_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Null_Access_Parameter
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Discriminant_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Divide_By_Zero
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Explicit_Raise
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Index_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Invalid_Data
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Length_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Null_Exception_Id
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Null_Not_Allowed
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Overflow_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Partition_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Range_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Tag_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Access_Before_Elaboration
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Accessibility_Check
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Address_Of_Intrinsic
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Aliased_Parameters
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_All_Guards_Closed
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Bad_Predicated_Generic_Type
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Build_In_Place_Mismatch
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Current_Task_In_Entry_Body
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Duplicated_Entry_Address
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Explicit_Raise
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Implicit_Return
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Misaligned_Address_Value
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Missing_Return
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Non_Transportable_Actual
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Overlaid_Controlled_Object
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Potentially_Blocking_Operation
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Stubbed_Subprogram_Called
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Unchecked_Union_Restriction
     (File : System.Address; Line : Integer);
   procedure Rcheck_SE_Empty_Storage_Pool
     (File : System.Address; Line : Integer);
   procedure Rcheck_SE_Explicit_Raise
     (File : System.Address; Line : Integer);
   procedure Rcheck_SE_Infinite_Recursion
     (File : System.Address; Line : Integer);
   procedure Rcheck_SE_Object_Too_Large
     (File : System.Address; Line : Integer);
   procedure Rcheck_PE_Stream_Operation_Not_Allowed
     (File : System.Address; Line : Integer);
   procedure Rcheck_CE_Access_Check_Ext
     (File : System.Address; Line, Column : Integer);
   procedure Rcheck_CE_Index_Check_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer);
   procedure Rcheck_CE_Invalid_Data_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer);
   procedure Rcheck_CE_Range_Check_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer);

   procedure Rcheck_PE_Finalize_Raised_Exception
     (File : System.Address; Line : Integer);
   --  This routine is separated out because it has quite different behavior
   --  from the others. This is the "finalize/adjust raised exception". This
   --  subprogram is always called with abort deferred, unlike all other
   --  Rcheck_* subprograms, it needs to call Raise_Exception_No_Defer.

   pragma Export (C, Rcheck_CE_Access_Check,
                  "__gnat_rcheck_CE_Access_Check");
   pragma Export (C, Rcheck_CE_Null_Access_Parameter,
                  "__gnat_rcheck_CE_Null_Access_Parameter");
   pragma Export (C, Rcheck_CE_Discriminant_Check,
                  "__gnat_rcheck_CE_Discriminant_Check");
   pragma Export (C, Rcheck_CE_Divide_By_Zero,
                  "__gnat_rcheck_CE_Divide_By_Zero");
   pragma Export (C, Rcheck_CE_Explicit_Raise,
                  "__gnat_rcheck_CE_Explicit_Raise");
   pragma Export (C, Rcheck_CE_Index_Check,
                  "__gnat_rcheck_CE_Index_Check");
   pragma Export (C, Rcheck_CE_Invalid_Data,
                  "__gnat_rcheck_CE_Invalid_Data");
   pragma Export (C, Rcheck_CE_Length_Check,
                  "__gnat_rcheck_CE_Length_Check");
   pragma Export (C, Rcheck_CE_Null_Exception_Id,
                  "__gnat_rcheck_CE_Null_Exception_Id");
   pragma Export (C, Rcheck_CE_Null_Not_Allowed,
                  "__gnat_rcheck_CE_Null_Not_Allowed");
   pragma Export (C, Rcheck_CE_Overflow_Check,
                  "__gnat_rcheck_CE_Overflow_Check");
   pragma Export (C, Rcheck_CE_Partition_Check,
                  "__gnat_rcheck_CE_Partition_Check");
   pragma Export (C, Rcheck_CE_Range_Check,
                  "__gnat_rcheck_CE_Range_Check");
   pragma Export (C, Rcheck_CE_Tag_Check,
                  "__gnat_rcheck_CE_Tag_Check");
   pragma Export (C, Rcheck_PE_Access_Before_Elaboration,
                  "__gnat_rcheck_PE_Access_Before_Elaboration");
   pragma Export (C, Rcheck_PE_Accessibility_Check,
                  "__gnat_rcheck_PE_Accessibility_Check");
   pragma Export (C, Rcheck_PE_Address_Of_Intrinsic,
                  "__gnat_rcheck_PE_Address_Of_Intrinsic");
   pragma Export (C, Rcheck_PE_Aliased_Parameters,
                  "__gnat_rcheck_PE_Aliased_Parameters");
   pragma Export (C, Rcheck_PE_All_Guards_Closed,
                  "__gnat_rcheck_PE_All_Guards_Closed");
   pragma Export (C, Rcheck_PE_Bad_Predicated_Generic_Type,
                  "__gnat_rcheck_PE_Bad_Predicated_Generic_Type");
   pragma Export (C, Rcheck_PE_Build_In_Place_Mismatch,
                  "__gnat_rcheck_PE_Build_In_Place_Mismatch");
   pragma Export (C, Rcheck_PE_Current_Task_In_Entry_Body,
                  "__gnat_rcheck_PE_Current_Task_In_Entry_Body");
   pragma Export (C, Rcheck_PE_Duplicated_Entry_Address,
                  "__gnat_rcheck_PE_Duplicated_Entry_Address");
   pragma Export (C, Rcheck_PE_Explicit_Raise,
                  "__gnat_rcheck_PE_Explicit_Raise");
   pragma Export (C, Rcheck_PE_Finalize_Raised_Exception,
                  "__gnat_rcheck_PE_Finalize_Raised_Exception");
   pragma Export (C, Rcheck_PE_Implicit_Return,
                  "__gnat_rcheck_PE_Implicit_Return");
   pragma Export (C, Rcheck_PE_Misaligned_Address_Value,
                  "__gnat_rcheck_PE_Misaligned_Address_Value");
   pragma Export (C, Rcheck_PE_Missing_Return,
                  "__gnat_rcheck_PE_Missing_Return");
   pragma Export (C, Rcheck_PE_Non_Transportable_Actual,
                  "__gnat_rcheck_PE_Non_Transportable_Actual");
   pragma Export (C, Rcheck_PE_Overlaid_Controlled_Object,
                  "__gnat_rcheck_PE_Overlaid_Controlled_Object");
   pragma Export (C, Rcheck_PE_Potentially_Blocking_Operation,
                  "__gnat_rcheck_PE_Potentially_Blocking_Operation");
   pragma Export (C, Rcheck_PE_Stream_Operation_Not_Allowed,
                  "__gnat_rcheck_PE_Stream_Operation_Not_Allowed");
   pragma Export (C, Rcheck_PE_Stubbed_Subprogram_Called,
                  "__gnat_rcheck_PE_Stubbed_Subprogram_Called");
   pragma Export (C, Rcheck_PE_Unchecked_Union_Restriction,
                  "__gnat_rcheck_PE_Unchecked_Union_Restriction");
   pragma Export (C, Rcheck_SE_Empty_Storage_Pool,
                  "__gnat_rcheck_SE_Empty_Storage_Pool");
   pragma Export (C, Rcheck_SE_Explicit_Raise,
                  "__gnat_rcheck_SE_Explicit_Raise");
   pragma Export (C, Rcheck_SE_Infinite_Recursion,
                  "__gnat_rcheck_SE_Infinite_Recursion");
   pragma Export (C, Rcheck_SE_Object_Too_Large,
                  "__gnat_rcheck_SE_Object_Too_Large");

   pragma Export (C, Rcheck_CE_Access_Check_Ext,
                  "__gnat_rcheck_CE_Access_Check_ext");
   pragma Export (C, Rcheck_CE_Index_Check_Ext,
                  "__gnat_rcheck_CE_Index_Check_ext");
   pragma Export (C, Rcheck_CE_Invalid_Data_Ext,
                  "__gnat_rcheck_CE_Invalid_Data_ext");
   pragma Export (C, Rcheck_CE_Range_Check_Ext,
                  "__gnat_rcheck_CE_Range_Check_ext");

   --  None of these procedures ever returns (they raise an exception). By
   --  using pragma No_Return, we ensure that any junk code after the call,
   --  such as normal return epilogue stuff, can be eliminated).

   pragma No_Return (Rcheck_CE_Access_Check);
   pragma No_Return (Rcheck_CE_Null_Access_Parameter);
   pragma No_Return (Rcheck_CE_Discriminant_Check);
   pragma No_Return (Rcheck_CE_Divide_By_Zero);
   pragma No_Return (Rcheck_CE_Explicit_Raise);
   pragma No_Return (Rcheck_CE_Index_Check);
   pragma No_Return (Rcheck_CE_Invalid_Data);
   pragma No_Return (Rcheck_CE_Length_Check);
   pragma No_Return (Rcheck_CE_Null_Exception_Id);
   pragma No_Return (Rcheck_CE_Null_Not_Allowed);
   pragma No_Return (Rcheck_CE_Overflow_Check);
   pragma No_Return (Rcheck_CE_Partition_Check);
   pragma No_Return (Rcheck_CE_Range_Check);
   pragma No_Return (Rcheck_CE_Tag_Check);
   pragma No_Return (Rcheck_PE_Access_Before_Elaboration);
   pragma No_Return (Rcheck_PE_Accessibility_Check);
   pragma No_Return (Rcheck_PE_Address_Of_Intrinsic);
   pragma No_Return (Rcheck_PE_Aliased_Parameters);
   pragma No_Return (Rcheck_PE_All_Guards_Closed);
   pragma No_Return (Rcheck_PE_Bad_Predicated_Generic_Type);
   pragma No_Return (Rcheck_PE_Build_In_Place_Mismatch);
   pragma No_Return (Rcheck_PE_Current_Task_In_Entry_Body);
   pragma No_Return (Rcheck_PE_Duplicated_Entry_Address);
   pragma No_Return (Rcheck_PE_Explicit_Raise);
   pragma No_Return (Rcheck_PE_Implicit_Return);
   pragma No_Return (Rcheck_PE_Misaligned_Address_Value);
   pragma No_Return (Rcheck_PE_Missing_Return);
   pragma No_Return (Rcheck_PE_Non_Transportable_Actual);
   pragma No_Return (Rcheck_PE_Overlaid_Controlled_Object);
   pragma No_Return (Rcheck_PE_Potentially_Blocking_Operation);
   pragma No_Return (Rcheck_PE_Stream_Operation_Not_Allowed);
   pragma No_Return (Rcheck_PE_Stubbed_Subprogram_Called);
   pragma No_Return (Rcheck_PE_Unchecked_Union_Restriction);
   pragma No_Return (Rcheck_PE_Finalize_Raised_Exception);
   pragma No_Return (Rcheck_SE_Empty_Storage_Pool);
   pragma No_Return (Rcheck_SE_Explicit_Raise);
   pragma No_Return (Rcheck_SE_Infinite_Recursion);
   pragma No_Return (Rcheck_SE_Object_Too_Large);

   pragma No_Return (Rcheck_CE_Access_Check_Ext);
   pragma No_Return (Rcheck_CE_Index_Check_Ext);
   pragma No_Return (Rcheck_CE_Invalid_Data_Ext);
   pragma No_Return (Rcheck_CE_Range_Check_Ext);

   ---------------------------------------------
   -- Reason Strings for Run-Time Check Calls --
   ---------------------------------------------

   --  These strings are null-terminated and are used by Rcheck_nn. The
   --  strings correspond to the definitions for Types.RT_Exception_Code.

   use ASCII;

   Rmsg_00 : constant String := "access check failed"              & NUL;
   Rmsg_01 : constant String := "access parameter is null"         & NUL;
   Rmsg_02 : constant String := "discriminant check failed"        & NUL;
   Rmsg_03 : constant String := "divide by zero"                   & NUL;
   Rmsg_04 : constant String := "explicit raise"                   & NUL;
   Rmsg_05 : constant String := "index check failed"               & NUL;
   Rmsg_06 : constant String := "invalid data"                     & NUL;
   Rmsg_07 : constant String := "length check failed"              & NUL;
   Rmsg_08 : constant String := "null Exception_Id"                & NUL;
   Rmsg_09 : constant String := "null-exclusion check failed"      & NUL;
   Rmsg_10 : constant String := "overflow check failed"            & NUL;
   Rmsg_11 : constant String := "partition check failed"           & NUL;
   Rmsg_12 : constant String := "range check failed"               & NUL;
   Rmsg_13 : constant String := "tag check failed"                 & NUL;
   Rmsg_14 : constant String := "access before elaboration"        & NUL;
   Rmsg_15 : constant String := "accessibility check failed"       & NUL;
   Rmsg_16 : constant String := "attempt to take address of"       &
                                " intrinsic subprogram"            & NUL;
   Rmsg_17 : constant String := "aliased parameters"               & NUL;
   Rmsg_18 : constant String := "all guards closed"                & NUL;
   Rmsg_19 : constant String := "improper use of generic subtype"  &
                                " with predicate"                  & NUL;
   Rmsg_20 : constant String := "Current_Task referenced in entry" &
                                " body"                            & NUL;
   Rmsg_21 : constant String := "duplicated entry address"         & NUL;
   Rmsg_22 : constant String := "explicit raise"                   & NUL;
   Rmsg_23 : constant String := "finalize/adjust raised exception" & NUL;
   Rmsg_24 : constant String := "implicit return with No_Return"   & NUL;
   Rmsg_25 : constant String := "misaligned address value"         & NUL;
   Rmsg_26 : constant String := "missing return"                   & NUL;
   Rmsg_27 : constant String := "overlaid controlled object"       & NUL;
   Rmsg_28 : constant String := "potentially blocking operation"   & NUL;
   Rmsg_29 : constant String := "stubbed subprogram called"        & NUL;
   Rmsg_30 : constant String := "unchecked union restriction"      & NUL;
   Rmsg_31 : constant String := "actual/returned class-wide"       &
                                " value not transportable"         & NUL;
   Rmsg_32 : constant String := "empty storage pool"               & NUL;
   Rmsg_33 : constant String := "explicit raise"                   & NUL;
   Rmsg_34 : constant String := "infinite recursion"               & NUL;
   Rmsg_35 : constant String := "object too large"                 & NUL;
   Rmsg_36 : constant String := "stream operation not allowed"     & NUL;
   Rmsg_37 : constant String := "build-in-place mismatch"          & NUL;

   -----------------------
   -- Polling Interface --
   -----------------------

   type Unsigned is mod 2 ** 32;

   Counter : Unsigned := 0;
   pragma Warnings (Off, Counter);
   --  This counter is provided for convenience. It can be used in Poll to
   --  perform periodic but not systematic operations.

   procedure Poll is separate;
   --  The actual polling routine is separate, so that it can easily be
   --  replaced with a target dependent version.

   --------------------------
   -- Code_Address_For_AAA --
   --------------------------

   --  This function gives us the start of the PC range for addresses within
   --  the exception unit itself. We hope that gigi/gcc keep all the procedures
   --  in their original order.

   function Code_Address_For_AAA return System.Address is
   begin
      --  We are using a label instead of Code_Address_For_AAA'Address because
      --  on some platforms the latter does not yield the address we want, but
      --  the address of a stub or of a descriptor instead. This is the case at
      --  least on PA-HPUX.

      <<Start_Of_AAA>>
      return Start_Of_AAA'Address;
   end Code_Address_For_AAA;


   ----------------------------
   -- Raise_Constraint_Error --
   ----------------------------

   procedure Raise_Constraint_Error (File : System.Address; Line : Integer) is null;

   --------------------------------
   -- Raise_Constraint_Error_Msg --
   --------------------------------

   procedure Raise_Constraint_Error_Msg
     (File   : System.Address;
      Line   : Integer;
      Column : Integer;
      Msg    : System.Address)
   is null;

   ------------------------------
   -- Raise_Exception_No_Defer --
   ------------------------------

   procedure Raise_Exception_No_Defer
     (E       : Exception_Id;
      Message : String := "")
   is 
   begin
      Last_Chance_Handler (Message'Address, 0);
   end Raise_Exception_No_Defer;

   ----------------------------
   -- Raise_Exception_Always --
   ----------------------------

   procedure Raise_Exception_Always
     (E       : Exception_Id;
      Message : String := "")
   is 
   begin
      Last_Chance_Handler (Message'Address, 0);
   end Raise_Exception_Always;

   -------------------------------
   -- Raise_From_Signal_Handler --
   -------------------------------

   procedure Raise_From_Signal_Handler
     (E : Exception_Id;
      M : System.Address)
   is null;

   -------------------------
   -- Raise_Program_Error --
   -------------------------

   procedure Raise_Program_Error
     (File : System.Address;
      Line : Integer)
   is null;

   -----------------------------
   -- Raise_Program_Error_Msg --
   -----------------------------

   procedure Raise_Program_Error_Msg
     (File : System.Address;
      Line : Integer;
      Msg  : System.Address)
   is null;

   -------------------------
   -- Raise_Storage_Error --
   -------------------------

   procedure Raise_Storage_Error
     (File : System.Address;
      Line : Integer)
   is null;

   -----------------------------
   -- Raise_Storage_Error_Msg --
   -----------------------------

   procedure Raise_Storage_Error_Msg
     (File : System.Address;
      Line : Integer;
      Msg  : System.Address)
   is null;

   --------------------
   -- Raise_With_Msg --
   --------------------

   procedure Raise_With_Msg (E : Exception_Id) is null;

   -----------------------------------------
   -- Calls to Run-Time Check Subprograms --
   -----------------------------------------

   procedure Rcheck_CE_Access_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_00'Address);
   end Rcheck_CE_Access_Check;

   procedure Rcheck_CE_Null_Access_Parameter
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_01'Address);
   end Rcheck_CE_Null_Access_Parameter;

   procedure Rcheck_CE_Discriminant_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_02'Address);
   end Rcheck_CE_Discriminant_Check;

   procedure Rcheck_CE_Divide_By_Zero
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_03'Address);
   end Rcheck_CE_Divide_By_Zero;

   procedure Rcheck_CE_Explicit_Raise
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_04'Address);
   end Rcheck_CE_Explicit_Raise;

   procedure Rcheck_CE_Index_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_05'Address);
   end Rcheck_CE_Index_Check;

   procedure Rcheck_CE_Invalid_Data
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_06'Address);
   end Rcheck_CE_Invalid_Data;

   procedure Rcheck_CE_Length_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_07'Address);
   end Rcheck_CE_Length_Check;

   procedure Rcheck_CE_Null_Exception_Id
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_08'Address);
   end Rcheck_CE_Null_Exception_Id;

   procedure Rcheck_CE_Null_Not_Allowed
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_09'Address);
   end Rcheck_CE_Null_Not_Allowed;

   procedure Rcheck_CE_Overflow_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_10'Address);
   end Rcheck_CE_Overflow_Check;

   procedure Rcheck_CE_Partition_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_11'Address);
   end Rcheck_CE_Partition_Check;

   procedure Rcheck_CE_Range_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_12'Address);
   end Rcheck_CE_Range_Check;

   procedure Rcheck_CE_Tag_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, 0, Rmsg_13'Address);
   end Rcheck_CE_Tag_Check;

   procedure Rcheck_PE_Access_Before_Elaboration
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_14'Address);
   end Rcheck_PE_Access_Before_Elaboration;

   procedure Rcheck_PE_Accessibility_Check
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_15'Address);
   end Rcheck_PE_Accessibility_Check;

   procedure Rcheck_PE_Address_Of_Intrinsic
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_16'Address);
   end Rcheck_PE_Address_Of_Intrinsic;

   procedure Rcheck_PE_Aliased_Parameters
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_17'Address);
   end Rcheck_PE_Aliased_Parameters;

   procedure Rcheck_PE_All_Guards_Closed
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_18'Address);
   end Rcheck_PE_All_Guards_Closed;

   procedure Rcheck_PE_Bad_Predicated_Generic_Type
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_19'Address);
   end Rcheck_PE_Bad_Predicated_Generic_Type;

   procedure Rcheck_PE_Build_In_Place_Mismatch
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_37'Address);
   end Rcheck_PE_Build_In_Place_Mismatch;

   procedure Rcheck_PE_Current_Task_In_Entry_Body
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_20'Address);
   end Rcheck_PE_Current_Task_In_Entry_Body;

   procedure Rcheck_PE_Duplicated_Entry_Address
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_21'Address);
   end Rcheck_PE_Duplicated_Entry_Address;

   procedure Rcheck_PE_Explicit_Raise
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_22'Address);
   end Rcheck_PE_Explicit_Raise;

   procedure Rcheck_PE_Implicit_Return
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_24'Address);
   end Rcheck_PE_Implicit_Return;

   procedure Rcheck_PE_Misaligned_Address_Value
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_25'Address);
   end Rcheck_PE_Misaligned_Address_Value;

   procedure Rcheck_PE_Missing_Return
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_26'Address);
   end Rcheck_PE_Missing_Return;

   procedure Rcheck_PE_Non_Transportable_Actual
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_31'Address);
   end Rcheck_PE_Non_Transportable_Actual;

   procedure Rcheck_PE_Overlaid_Controlled_Object
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_27'Address);
   end Rcheck_PE_Overlaid_Controlled_Object;

   procedure Rcheck_PE_Potentially_Blocking_Operation
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_28'Address);
   end Rcheck_PE_Potentially_Blocking_Operation;

   procedure Rcheck_PE_Stream_Operation_Not_Allowed
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_36'Address);
   end Rcheck_PE_Stream_Operation_Not_Allowed;

   procedure Rcheck_PE_Stubbed_Subprogram_Called
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_29'Address);
   end Rcheck_PE_Stubbed_Subprogram_Called;

   procedure Rcheck_PE_Unchecked_Union_Restriction
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Program_Error_Msg (File, Line, Rmsg_30'Address);
   end Rcheck_PE_Unchecked_Union_Restriction;

   procedure Rcheck_SE_Empty_Storage_Pool
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Storage_Error_Msg (File, Line, Rmsg_32'Address);
   end Rcheck_SE_Empty_Storage_Pool;

   procedure Rcheck_SE_Explicit_Raise
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Storage_Error_Msg (File, Line, Rmsg_33'Address);
   end Rcheck_SE_Explicit_Raise;

   procedure Rcheck_SE_Infinite_Recursion
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Storage_Error_Msg (File, Line, Rmsg_34'Address);
   end Rcheck_SE_Infinite_Recursion;

   procedure Rcheck_SE_Object_Too_Large
     (File : System.Address; Line : Integer)
   is
   begin
      Raise_Storage_Error_Msg (File, Line, Rmsg_35'Address);
   end Rcheck_SE_Object_Too_Large;

   procedure Rcheck_CE_Access_Check_Ext
     (File : System.Address; Line, Column : Integer)
   is
   begin
      Raise_Constraint_Error_Msg (File, Line, Column, Rmsg_00'Address);
   end Rcheck_CE_Access_Check_Ext;

   procedure Rcheck_CE_Index_Check_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer)
   is      
   begin
      Raise_Constraint_Error_Msg (File, Line, Column, Rmsg_05'Address);
   end Rcheck_CE_Index_Check_Ext;

   procedure Rcheck_CE_Invalid_Data_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer)
   is      
   begin
      Raise_Constraint_Error_Msg (File, Line, Column, Rmsg_06'Address);
   end Rcheck_CE_Invalid_Data_Ext;

   procedure Rcheck_CE_Range_Check_Ext
     (File : System.Address; Line, Column, Index, First, Last : Integer)
   is      
   begin
      Raise_Constraint_Error_Msg (File, Line, Column, Rmsg_12'Address);
   end Rcheck_CE_Range_Check_Ext;

   procedure Rcheck_PE_Finalize_Raised_Exception
     (File : System.Address; Line : Integer)
   is null;


end Ada.Exceptions;
