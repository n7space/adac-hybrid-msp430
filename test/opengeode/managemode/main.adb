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

with Interfaces;
use Interfaces;

with DemoSat_Types;
use DemoSat_Types;

with TASTE_BasicTypes;
use TASTE_BasicTypes;

with PUS_C;
use PUS_C;

with reporting;
with managemode;
with envstub;

-- Reference
-- procedure trigger_gather_mode_hk;
-- procedure command_mode(requested_mode: access asn1SccSATELLITE_MODE);
-- procedure command_voltage(safe_voltage: access asn1SccVOLTAGE);
-- voltage :asn1SccVOLTAGE := 0.0;
-- modeHk : asn1SccMODE_HK_DATA;
-- executionReport : asn1SccEXECUTION_REPORT;
-- thermalEnabled : asn1SccT_Boolean;
-- payloadEnabled : asn1SccT_Boolean;
-- getCurrentVoltageCalled : Boolean;
-- modeHkStoreCalled : Boolean;
-- reportModeCalled : Boolean;
-- reportVoltageCalled : Boolean;
-- switchPayloadCalled : Boolean;
-- switchThermalCalled : Boolean;

procedure Main is
    requested_mode : aliased asn1SccSATELLITE_MODE;
    safe_voltage : aliased asn1SccVOLTAGE := 5.0;

    failed : Boolean := False;


    function test_gatherHkInIdle return Boolean is
    begin
        envstub.Reset;
        -- Safe voltage is 5.0
        -- Current voltage is 10.0
        -- Assumed mode is IDLE
        envstub.voltage := 10.0;

        managemode.trigger_gather_mode_hk;
        if not envstub.getCurrentVoltageCalled then
            return False;
        end if;
        if not envstub.modeHkStoreCalled then
            return False;
        end if;
        if envstub.modeHk.mode /= asn1Sccsatellite_mode_idle then
            return False;
        end if;
        if envstub.modeHk.input_voltage /= envstub.voltage then
            return False;
        end if;

        reporting.ReportInfo("Idle HK OK");
        return True;
    end test_gatherHkInIdle;

    function test_setSafeVoltage return Boolean is
    begin
        envstub.Reset;
        envstub.voltage := 10.0;
        safe_voltage := 5.0;
        managemode.command_voltage(safe_voltage'Access);
        if not envstub.reportVoltageCalled then
            return False;
        end if;
        if envstub.executionReport.kind /= execution_report_success_PRESENT then
            return False;
        end if;
        reporting.ReportInfo("Set voltage OK");
        return True;
    end test_setSafeVoltage;

    function test_commandMode return Boolean is
    begin
        envstub.Reset;
        envstub.voltage := 10.0;
        requested_mode := asn1Sccsatellite_mode_operational;
        managemode.command_mode(requested_mode'Access);
        if envstub.executionReport.kind /= execution_report_success_PRESENT then
            return False;
        end if;

        if not envstub.switchThermalCalled then
            return False;
        end if;
        if not envstub.thermalEnabled then
            return False;
        end if;

        if not envstub.switchPayloadCalled then
            return False;
        end if;
        if not envstub.payloadEnabled then
            return False;
        end if;

        managemode.trigger_gather_mode_hk;
        if envstub.modeHk.mode /= asn1Sccsatellite_mode_operational then
            return False;
        end if;
        reporting.ReportInfo("Cmd mode OK");
        return True;
    end test_commandMode;

    function test_safeEntry return Boolean is
    begin
        envstub.Reset;
        -- Safe voltage is 5.0
        -- Assumed mode is OPERATIONAL
        -- Voltage of -2.0 should trigger a transition into SAFE
        envstub.voltage := -2.0;

        -- The first gathering triggers the transition
        managemode.trigger_gather_mode_hk;
        if not envstub.getCurrentVoltageCalled then
            return False;
        end if;
        if not envstub.modeHkStoreCalled then
            return False;
        end if;
        if envstub.modeHk.mode /= asn1Sccsatellite_mode_safe then
            return False;
        end if;

        if not envstub.switchThermalCalled then
            return False;
        end if;
        if envstub.thermalEnabled then
            return False;
        end if;
        if not envstub.switchPayloadCalled then
            return False;
        end if;
        if envstub.payloadEnabled then
            return False;
        end if;

        if envstub.modeHk.input_voltage /= envstub.voltage then
            return False;
        end if;

        reporting.ReportInfo("Safe entry OK");
        return True;
    end test_safeEntry;

begin
    reporting.Init;

    if not test_setSafeVoltage then
        failed := True;
        reporting.ReportErrorString("cmdVoltage");
    end if;
    if not test_gatherHkInIdle then
        failed := True;
        reporting.ReportErrorString("cmdHkIdle");
    end if;
    if not test_commandMode then
        failed := True;
        reporting.ReportErrorString("cmdMode");
    end if;
    if not test_safeEntry then
        failed := True;
        reporting.ReportErrorString("safeEntry");
    end if;

    if not failed then
        reporting.ReportSuccess;
    end if;
    loop
        null;
    end loop;
end;
