-- This file is part of the adac-hybrid-msp430 distribution
-- Copyright (C) 2020, European Space Agency
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

with DemoSat_Types;
use DemoSat_Types;

with TASTE_BasicTypes;
use TASTE_BasicTypes;

with PUS_C;
use PUS_C;

package envstub is

  voltage :asn1SccVOLTAGE := 0.0;
  modeHk : asn1SccMODE_HK_DATA;
  executionReport : asn1SccEXECUTION_REPORT;
  thermalEnabled : asn1SccT_Boolean := False;
  payloadEnabled : asn1SccT_Boolean := False;

  getCurrentVoltageCalled : Boolean := False;
  modeHkStoreCalled : Boolean := False;
  reportModeCalled : Boolean := False;
  reportVoltageCalled : Boolean := False;
  switchPayloadCalled : Boolean := False;
  switchThermalCalled : Boolean := False;

  procedure Reset;

  --  Sync required interface "get_current_voltage"
  procedure RI�get_current_voltage(Current_Voltage: access asn1SccVOLTAGE);
  pragma export(C, RI�get_current_voltage, "managemode_RI_get_current_voltage");
  --  Sync required interface "mode_hk_store"
  procedure RI�mode_hk_store(Param_Mode_Telemetry: access asn1SccMODE_HK_DATA);
  pragma export(C, RI�mode_hk_store, "managemode_RI_mode_hk_store");
  --  Sync required interface "report_mode"
  procedure RI�report_mode(Execution_Report_Value: access asn1SccEXECUTION_REPORT);
  pragma export(C, RI�report_mode, "managemode_RI_report_mode");
  --  Sync required interface "report_voltage"
  procedure RI�report_voltage(Execution_Report_Value: access asn1SccEXECUTION_REPORT);
  pragma export(C, RI�report_voltage, "managemode_RI_report_voltage");
  --  Sync required interface "switch_payload"
  procedure RI�switch_payload(Enabled: access asn1SccT_Boolean);
  pragma export(C, RI�switch_payload, "managemode_RI_switch_payload");
  --  Sync required interface "switch_thermal"
  procedure RI�switch_thermal(Param_Enabled: access asn1SccT_Boolean);
  pragma export(C, RI�switch_thermal, "managemode_RI_switch_thermal");

end envstub;
