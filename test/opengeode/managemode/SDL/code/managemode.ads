-- This file was generated automatically: DO NOT MODIFY IT !

with PUS_C;
use PUS_C;
with DemoSat_Types;
use DemoSat_Types;
with TASTE_BasicTypes;
use TASTE_BasicTypes;
with adaasn1rtl;
use adaasn1rtl;



package Managemode is
   --  Provided interface "trigger_gather_mode_hk"
   procedure trigger_gather_mode_hk;
   pragma Export(C, trigger_gather_mode_hk, "managemode_PI_trigger_gather_mode_hk");
   --  Provided interface "command_mode"
   procedure command_mode(requested_mode: access asn1SccSATELLITE_MODE);
   pragma Export(C, command_mode, "managemode_PI_command_mode");
   --  Provided interface "command_voltage"
   procedure command_voltage(safe_voltage: access asn1SccVOLTAGE);
   pragma Export(C, command_voltage, "managemode_PI_command_voltage");
   --  Sync required interface "get_current_voltage"
   procedure RI�get_current_voltage(Current_Voltage: access asn1SccVOLTAGE);
   pragma import(C, RI�get_current_voltage, "managemode_RI_get_current_voltage");
   --  Sync required interface "mode_hk_store"
   procedure RI�mode_hk_store(Param_Mode_Telemetry: access asn1SccMODE_HK_DATA);
   pragma import(C, RI�mode_hk_store, "managemode_RI_mode_hk_store");
   --  Sync required interface "report_mode"
   procedure RI�report_mode(Execution_Report_Value: access asn1SccEXECUTION_REPORT);
   pragma import(C, RI�report_mode, "managemode_RI_report_mode");
   --  Sync required interface "report_voltage"
   procedure RI�report_voltage(Execution_Report_Value: access asn1SccEXECUTION_REPORT);
   pragma import(C, RI�report_voltage, "managemode_RI_report_voltage");
   --  Sync required interface "switch_payload"
   procedure RI�switch_payload(Enabled: access asn1SccT_Boolean);
   pragma import(C, RI�switch_payload, "managemode_RI_switch_payload");
   --  Sync required interface "switch_thermal"
   procedure RI�switch_thermal(Param_Enabled: access asn1SccT_Boolean);
   pragma import(C, RI�switch_thermal, "managemode_RI_switch_thermal");
end Managemode;