-- This file was generated automatically: DO NOT MODIFY IT !

with BASIC_SDL_DATAVIEW;
use BASIC_SDL_DATAVIEW;
with TASTE_BasicTypes;
use TASTE_BasicTypes;
with adaasn1rtl;
use adaasn1rtl;



package Basicsdl is
   --  Provided interface "toSdl"
   procedure toSdl(param1: access asn1SccT_Int32);
   pragma Export(C, toSdl, "basicsdl_PI_toSdl");
   --  Required interface "toGui"
   procedure RIÜtoGui(param1: access asn1SccT_Boolean);
   pragma import(C, RIÜtoGui, "basicsdl_RI_toGui");
end Basicsdl;