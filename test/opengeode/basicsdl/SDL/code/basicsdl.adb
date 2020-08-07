-- This file was generated automatically: DO NOT MODIFY IT !

with System.IO;
use System.IO;

with Ada.Unchecked_Conversion;
with Ada.Numerics.Generic_Elementary_Functions;

with BASIC_SDL_DATAVIEW;
use BASIC_SDL_DATAVIEW;
with TASTE_BasicTypes;
use TASTE_BasicTypes;
with adaasn1rtl;
use adaasn1rtl;


with Interfaces;
use Interfaces;

package body Basicsdl is
   type States is (positive, negative, wait);
   type ctxt_Ty is
      record
      state : States;
      initDone : Boolean := False;
      x : aliased asn1SccT_Int32;
   end record;
   ctxt: aliased ctxt_Ty;
   CS_Only  : constant Integer := 4;
   procedure runTransition(Id: Integer);
   procedure toSdl(param1: access asn1SccT_Int32) is
      begin
         case ctxt.state is
            when positive =>
               ctxt.x := param1.all;
               runTransition(3);
            when negative =>
               ctxt.x := param1.all;
               runTransition(2);
            when wait =>
               ctxt.x := param1.all;
               runTransition(1);
            when others =>
               runTransition(CS_Only);
         end case;
      end toSdl;
      

   procedure runTransition(Id: Integer) is
      trId : Integer := Id;
      tmp16 : aliased asn1SccT_Boolean;
      tmp9 : aliased asn1SccT_Boolean;
      tmp6 : aliased asn1SccT_Boolean;
      --  !! stack: _call_external_function line 1371
      tmp24 : aliased asn1SccT_Boolean;
      begin
         while (trId /= -1) loop
            case trId is
               when 0 =>
                  --  NEXT_STATE Wait (11,18) at 320, 60
                  trId := -1;
                  ctxt.state := Wait;
                  goto next_transition;
               when 1 =>
                  --  DECISION x >= 0 (17,23)
                  --  ANSWER True (19,17)
                  if ((ctxt.x >= 0)) = true then
                     --  toGui(True) (21,27)
                     tmp6 := true;
                     RIÜtoGui(tmp6'Access);
                     --  NEXT_STATE Positive (23,30) at 411, 294
                     trId := -1;
                     ctxt.state := Positive;
                     goto next_transition;
                     --  ANSWER False (25,17)
                  elsif ((ctxt.x >= 0)) = false then
                     --  ToGui(False) (27,27)
                     tmp9 := false;
                     RIÜToGui(tmp9'Access);
                     --  NEXT_STATE Negative (29,30) at 512, 292
                     trId := -1;
                     ctxt.state := Negative;
                     goto next_transition;
                  end if;
               when 2 =>
                  --  DECISION x > 0 (37,23)
                  --  ANSWER True (39,17)
                  if ((ctxt.x > 0)) = true then
                     --  ToGui(True) (41,27)
                     tmp16 := true;
                     RIÜToGui(tmp16'Access);
                     --  NEXT_STATE Positive (43,30) at 808, 300
                     trId := -1;
                     ctxt.state := Positive;
                     goto next_transition;
                     --  ANSWER False (45,17)
                  elsif ((ctxt.x > 0)) = false then
                     --  NEXT_STATE NEgative (47,30) at 895, 245
                     trId := -1;
                     ctxt.state := NEgative;
                     goto next_transition;
                  end if;
               when 3 =>
                  --  DECISION x < 0 (55,23)
                  --  ANSWER True (57,17)
                  if ((ctxt.x < 0)) = true then
                     --  ToGui(False) (59,27)
                     tmp24 := false;
                     RIÜToGui(tmp24'Access);
                     --  NEXT_STATE Negative (61,30) at 622, 301
                     trId := -1;
                     ctxt.state := Negative;
                     goto next_transition;
                     --  ANSWER False (63,17)
                  elsif ((ctxt.x < 0)) = false then
                     --  NEXT_STATE Positive (65,30) at 715, 246
                     trId := -1;
                     ctxt.state := Positive;
                     goto next_transition;
                  end if;
               when CS_Only =>
                  trId := -1;
                  goto next_transition;
               when others =>
                  null;
            end case;
            <<next_transition>>
            null;
         end loop;
      end runTransition;
      

   begin
      runTransition(0);
      ctxt.initDone := True;
end Basicsdl;