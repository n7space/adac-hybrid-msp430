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

package body envstub is

    procedure Reset is
    begin
        voltage  := 0.0;
        thermalEnabled := False;
        payloadEnabled := False;
        getCurrentVoltageCalled := False;
        modeHkStoreCalled := False;
        reportModeCalled := False;
        reportVoltageCalled := False;
        switchPayloadCalled := False;
        switchThermalCalled := False;
    end Reset;

    procedure RI�get_current_voltage(Current_Voltage: access asn1SccVOLTAGE) is
    begin
        getCurrentVoltageCalled := True;
        Current_Voltage.all := voltage;
    end;

    procedure RI�mode_hk_store(Param_Mode_Telemetry: access asn1SccMODE_HK_DATA) is
    begin
        modeHkStoreCalled := True;
        modeHk := Param_Mode_Telemetry.all;
    end;

    procedure RI�report_mode(Execution_Report_Value: access asn1SccEXECUTION_REPORT) is
    begin
        reportModeCalled := True;
        executionReport := Execution_Report_Value.all;
    end;

    procedure RI�report_voltage(Execution_Report_Value: access asn1SccEXECUTION_REPORT) is
    begin
        reportVoltageCalled := True;
        executionReport := Execution_Report_Value.all;
    end;

    procedure RI�switch_payload(Enabled: access asn1SccT_Boolean) is
    begin
        switchPayloadCalled := True;
        payloadEnabled := Enabled.all;
    end;

    procedure RI�switch_thermal(Param_Enabled: access asn1SccT_Boolean) is
    begin
        switchThermalCalled := True;
        thermalEnabled := Param_Enabled.all;
    end;

end envstub;
