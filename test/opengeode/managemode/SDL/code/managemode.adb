-- This file was generated automatically: DO NOT MODIFY IT !

with System.IO;
use System.IO;

with Ada.Unchecked_Conversion;
with Ada.Numerics.Generic_Elementary_Functions;

with PUS_C;
use PUS_C;
with DemoSat_Types;
use DemoSat_Types;
with TASTE_BasicTypes;
use TASTE_BasicTypes;
with adaasn1rtl;
use adaasn1rtl;


with Interfaces;
use Interfaces;

package body Managemode is
   type States is (idle, safe, operational);
   type ctxt_Ty is
      record
      state : States;
      initDone : Boolean := False;
      mode_voltage_threshold : aliased asn1SccVOLTAGE := 1.0;
      param_voltage : aliased asn1SccVOLTAGE;
      param_satellite_mode : aliased asn1SccSATELLITE_MODE;
      param_execution_report : aliased asn1SccEXECUTION_REPORT;
      param_mode_hk : aliased asn1SccMODE_HK_DATA;
      mode_current_voltage : aliased asn1SccVOLTAGE := 0.0;
   end record;
   ctxt: aliased ctxt_Ty;
   CS_Only  : constant Integer := 10;
   procedure runTransition(Id: Integer);
   procedure pÜfill_param_mode_hk(mode_to_set: in asn1SccSATELLITE_MODE);
   procedure pÜfill_param_mode_hk(mode_to_set: in asn1SccSATELLITE_MODE) is
      begin
         --  param_mode_hk := {
         --  mode mode_to_set,
         --  input_voltage mode_current_voltage
         --  } (27,17)
         ctxt.param_mode_hk := asn1SccMODE_HK_DATA'( mode => mode_to_set,  input_voltage => ctxt.mode_current_voltage);
         --  RETURN  (None,None) at 383, 368
         return;
      end pÜfill_param_mode_hk;
      

   procedure trigger_gather_mode_hk is
      begin
         case ctxt.state is
            when idle =>
               runTransition(8);
            when safe =>
               runTransition(6);
            when operational =>
               runTransition(7);
            when others =>
               runTransition(CS_Only);
         end case;
      end trigger_gather_mode_hk;
      

   procedure command_mode(requested_mode: access asn1SccSATELLITE_MODE) is
      begin
         case ctxt.state is
            when idle =>
               ctxt.param_satellite_mode := requested_mode.all;
               runTransition(9);
            when safe =>
               ctxt.param_satellite_mode := requested_mode.all;
               runTransition(1);
            when operational =>
               ctxt.param_satellite_mode := requested_mode.all;
               runTransition(5);
            when others =>
               runTransition(CS_Only);
         end case;
      end command_mode;
      

   procedure command_voltage(safe_voltage: access asn1SccVOLTAGE) is
      begin
         case ctxt.state is
            when idle =>
               ctxt.param_voltage := safe_voltage.all;
               runTransition(4);
            when safe =>
               ctxt.param_voltage := safe_voltage.all;
               runTransition(2);
            when operational =>
               ctxt.param_voltage := safe_voltage.all;
               runTransition(3);
            when others =>
               runTransition(CS_Only);
         end case;
      end command_voltage;
      

   procedure runTransition(Id: Integer) is
      trId : Integer := Id;
      tmp5 : aliased asn1SccT_Boolean;
      tmp13 : aliased asn1SccT_Boolean;
      --  !! stack: _call_external_function line 1371
      tmp9 : aliased asn1SccT_Boolean;
      tmp11 : aliased asn1SccT_Boolean;
      tmp7 : aliased asn1SccT_Boolean;
      tmp3 : aliased asn1SccT_Boolean;
      begin
         while (trId /= -1) loop
            case trId is
               when 0 =>
                  --  NEXT_STATE Idle (37,18) at 9, 335
                  trId := -1;
                  ctxt.state := Idle;
                  goto next_transition;
               when 1 =>
                  --  DECISION param_satellite_mode (-1,-1)
                  --  ANSWER satellite_mode_safe (75,17)
                  if (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_safe then
                     --  param_execution_report := execution_report_failed : {
                     --      failedStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode,
                     --          failureNoticeData failure_notice_code_invalid_mode :{
                     --              mode satellite_mode_safe,
                     --              input_voltage mode_current_voltage
                     --          }
                     --      }
                     --  } (77,25)
                     ctxt.param_execution_report := (Kind => execution_report_failed_PRESENT, execution_report_failed => asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type'( failedStartOfExecutionNotificationNotification => asn1SccFailedStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode,  failureNoticeData => (Kind => failure_notice_code_invalid_mode_PRESENT, failure_notice_code_invalid_mode => asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_mode'( mode => asn1Sccsatellite_mode_safe,  input_voltage => ctxt.mode_current_voltage)))));
                     --  report_mode(param_execution_report) (87,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  NEXT_STATE Safe (89,30) at 930, 675
                     trId := -1;
                     ctxt.state := Safe;
                     goto next_transition;
                     --  ANSWER satellite_mode_idle (91,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_idle then
                     --  DECISION mode_current_voltage >= mode_voltage_threshold (93,50)
                     --  ANSWER true (95,25)
                     if ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = true then
                        --  param_execution_report := execution_report_success : {
                        --      successfulStartOfExecutionNotificationNotification {
                        --          requestID request_id_switch_mode
                        --      }
                        --  } (97,33)
                        ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode)));
                        --  report_mode(param_execution_report) (103,33)
                        RIÜreport_mode(ctxt.param_execution_report'Access);
                        --  JOIN Idle_Entry (105,33) at 1366, 723
                        goto Idle_Entry;
                        --  ANSWER false (107,25)
                     elsif ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = false then
                        --  param_execution_report := execution_report_failed : {
                        --      failedStartOfExecutionNotificationNotification {
                        --          requestID request_id_switch_mode,
                        --          failureNoticeData failure_notice_code_invalid_mode :{
                        --              mode satellite_mode_safe,
                        --              input_voltage mode_current_voltage
                        --          }
                        --      }
                        --  } (109,33)
                        ctxt.param_execution_report := (Kind => execution_report_failed_PRESENT, execution_report_failed => asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type'( failedStartOfExecutionNotificationNotification => asn1SccFailedStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode,  failureNoticeData => (Kind => failure_notice_code_invalid_mode_PRESENT, failure_notice_code_invalid_mode => asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_mode'( mode => asn1Sccsatellite_mode_safe,  input_voltage => ctxt.mode_current_voltage)))));
                        --  report_mode(param_execution_report) (119,33)
                        RIÜreport_mode(ctxt.param_execution_report'Access);
                        --  NEXT_STATE Safe (121,38) at 1753, 798
                        trId := -1;
                        ctxt.state := Safe;
                        goto next_transition;
                     end if;
                     --  ANSWER satellite_mode_operational (124,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_operational then
                     --  param_execution_report := execution_report_failed : {
                     --      failedStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode,
                     --          failureNoticeData failure_notice_code_invalid_mode :{
                     --              mode satellite_mode_safe,
                     --              input_voltage mode_current_voltage
                     --          }
                     --      }
                     --  } (126,25)
                     ctxt.param_execution_report := (Kind => execution_report_failed_PRESENT, execution_report_failed => asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type'( failedStartOfExecutionNotificationNotification => asn1SccFailedStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode,  failureNoticeData => (Kind => failure_notice_code_invalid_mode_PRESENT, failure_notice_code_invalid_mode => asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_mode'( mode => asn1Sccsatellite_mode_safe,  input_voltage => ctxt.mode_current_voltage)))));
                     --  report_mode(param_execution_report) (136,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  NEXT_STATE Safe (138,30) at 2188, 723
                     trId := -1;
                     ctxt.state := Safe;
                     goto next_transition;
                  end if;
               when 2 =>
                  --  mode_voltage_threshold := param_voltage (146,17)
                  ctxt.mode_voltage_threshold := ctxt.param_voltage;
                  --  param_execution_report := execution_report_success : {
                  --      successfulStartOfExecutionNotificationNotification {
                  --          requestID request_id_set_threshold_voltage
                  --      }
                  --  } (148,17)
                  ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_set_threshold_voltage)));
                  --  report_voltage(param_execution_report) (154,17)
                  RIÜreport_voltage(ctxt.param_execution_report'Access);
                  --  NEXT_STATE Safe (156,22) at 2722, 546
                  trId := -1;
                  ctxt.state := Safe;
                  goto next_transition;
               when 3 =>
                  --  mode_voltage_threshold := param_voltage (163,17)
                  ctxt.mode_voltage_threshold := ctxt.param_voltage;
                  --  param_execution_report := execution_report_success : {
                  --      successfulStartOfExecutionNotificationNotification {
                  --          requestID request_id_set_threshold_voltage
                  --      }
                  --  } (165,17)
                  ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_set_threshold_voltage)));
                  --  report_voltage(param_execution_report) (171,17)
                  RIÜreport_voltage(ctxt.param_execution_report'Access);
                  --  NEXT_STATE Idle (173,22) at 2719, 1509
                  trId := -1;
                  ctxt.state := Idle;
                  goto next_transition;
               when 4 =>
                  --  mode_voltage_threshold := param_voltage (180,17)
                  ctxt.mode_voltage_threshold := ctxt.param_voltage;
                  --  param_execution_report := execution_report_success : {
                  --      successfulStartOfExecutionNotificationNotification {
                  --          requestID request_id_set_threshold_voltage
                  --      }
                  --  } (182,17)
                  ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_set_threshold_voltage)));
                  --  report_voltage(param_execution_report) (188,17)
                  RIÜreport_voltage(ctxt.param_execution_report'Access);
                  --  NEXT_STATE Idle (190,22) at 2715, 1016
                  trId := -1;
                  ctxt.state := Idle;
                  goto next_transition;
               when 5 =>
                  --  DECISION param_satellite_mode (-1,-1)
                  --  ANSWER satellite_mode_safe (199,17)
                  if (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_safe then
                     --  param_execution_report := execution_report_success : {
                     --      successfulStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode
                     --      }
                     --  } (201,25)
                     ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode)));
                     --  report_mode(param_execution_report) (207,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  JOIN Safe_Entry (209,25) at 681, 1864
                     goto Safe_Entry;
                     --  ANSWER satellite_mode_idle (211,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_idle then
                     --  param_execution_report := execution_report_success : {
                     --      successfulStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode
                     --      }
                     --  } (213,25)
                     ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode)));
                     --  report_mode(param_execution_report) (219,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  JOIN Idle_Entry (221,25) at 1055, 1864
                     goto Idle_Entry;
                     --  ANSWER satellite_mode_operational (223,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_operational then
                     --  param_execution_report := execution_report_failed : {
                     --      failedStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode,
                     --          failureNoticeData failure_notice_code_invalid_state : disabled
                     --      }
                     --  } (225,25)
                     ctxt.param_execution_report := (Kind => execution_report_failed_PRESENT, execution_report_failed => asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type'( failedStartOfExecutionNotificationNotification => asn1SccFailedStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode,  failureNoticeData => (Kind => failure_notice_code_invalid_state_PRESENT, failure_notice_code_invalid_state => asn1Sccdisabled))));
                     --  report_mode(param_execution_report) (232,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  NEXT_STATE Operational (234,30) at 1427, 1894
                     trId := -1;
                     ctxt.state := Operational;
                     goto next_transition;
                  end if;
               when 6 =>
                  --  get_current_voltage(mode_current_voltage) (242,17)
                  RIÜget_current_voltage(ctxt.mode_current_voltage'Access);
                  --  fill_param_mode_hk(satellite_mode_safe) (244,17)
                  pÜfill_param_mode_hk(asn1Sccsatellite_mode_safe);
                  --  mode_hk_store(param_mode_hk) (246,17)
                  RIÜmode_hk_store(ctxt.param_mode_hk'Access);
                  --  NEXT_STATE Safe (248,22) at 289, 548
                  trId := -1;
                  ctxt.state := Safe;
                  goto next_transition;
               when 7 =>
                  --  get_current_voltage(mode_current_voltage) (255,17)
                  RIÜget_current_voltage(ctxt.mode_current_voltage'Access);
                  --  DECISION mode_current_voltage >= mode_voltage_threshold (257,42)
                  --  ANSWER false (259,17)
                  if ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = false then
                     --  fill_param_mode_hk(satellite_mode_safe) (261,25)
                     pÜfill_param_mode_hk(asn1Sccsatellite_mode_safe);
                     --  mode_hk_store(param_mode_hk) (263,25)
                     RIÜmode_hk_store(ctxt.param_mode_hk'Access);
                     --  JOIN Safe_Entry (265,25) at 141, 1551
                     goto Safe_Entry;
                     --  ANSWER true (267,17)
                  elsif ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = true then
                     --  fill_param_mode_hk(satellite_mode_operational) (269,25)
                     pÜfill_param_mode_hk(asn1Sccsatellite_mode_operational);
                     --  mode_hk_store(param_mode_hk) (271,25)
                     RIÜmode_hk_store(ctxt.param_mode_hk'Access);
                     --  NEXT_STATE Operational (273,30) at 421, 1551
                     trId := -1;
                     ctxt.state := Operational;
                     goto next_transition;
                  end if;
               when 8 =>
                  --  get_current_voltage(mode_current_voltage) (281,17)
                  RIÜget_current_voltage(ctxt.mode_current_voltage'Access);
                  --  DECISION mode_current_voltage >= mode_voltage_threshold (283,42)
                  --  ANSWER false (285,17)
                  if ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = false then
                     --  fill_param_mode_hk(satellite_mode_safe) (287,25)
                     pÜfill_param_mode_hk(asn1Sccsatellite_mode_safe);
                     --  mode_hk_store(param_mode_hk) (289,25)
                     RIÜmode_hk_store(ctxt.param_mode_hk'Access);
                     --  JOIN Safe_Entry (291,25) at 170, 1066
                     goto Safe_Entry;
                     --  ANSWER true (293,17)
                  elsif ((ctxt.mode_current_voltage >= ctxt.mode_voltage_threshold)) = true then
                     --  fill_param_mode_hk(satellite_mode_idle) (295,25)
                     pÜfill_param_mode_hk(asn1Sccsatellite_mode_idle);
                     --  mode_hk_store(param_mode_hk) (297,25)
                     RIÜmode_hk_store(ctxt.param_mode_hk'Access);
                     --  NEXT_STATE Idle (299,30) at 440, 1066
                     trId := -1;
                     ctxt.state := Idle;
                     goto next_transition;
                  end if;
               when 9 =>
                  --  DECISION param_satellite_mode (-1,-1)
                  --  ANSWER satellite_mode_safe (309,17)
                  if (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_safe then
                     --  param_execution_report := execution_report_success : {
                     --      successfulStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode
                     --      }
                     --  } (311,25)
                     ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode)));
                     --  report_mode(param_execution_report) (317,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  JOIN Safe_Entry (319,25) at 1265, 1264
                     goto Safe_Entry;
                     --  ANSWER satellite_mode_idle (321,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_idle then
                     --  param_execution_report := execution_report_failed : {
                     --      failedStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode,
                     --          failureNoticeData failure_notice_code_invalid_mode :{
                     --              mode satellite_mode_safe,
                     --              input_voltage mode_current_voltage
                     --          }
                     --      }
                     --  } (323,25)
                     ctxt.param_execution_report := (Kind => execution_report_failed_PRESENT, execution_report_failed => asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type'( failedStartOfExecutionNotificationNotification => asn1SccFailedStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode,  failureNoticeData => (Kind => failure_notice_code_invalid_mode_PRESENT, failure_notice_code_invalid_mode => asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_mode'( mode => asn1Sccsatellite_mode_safe,  input_voltage => ctxt.mode_current_voltage)))));
                     --  report_mode(param_execution_report) (333,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  NEXT_STATE Idle (335,30) at 1652, 1382
                     trId := -1;
                     ctxt.state := Idle;
                     goto next_transition;
                     --  ANSWER satellite_mode_operational (337,17)
                  elsif (ctxt.param_satellite_mode) = asn1Sccsatellite_mode_operational then
                     --  param_execution_report := execution_report_success : {
                     --      successfulStartOfExecutionNotificationNotification {
                     --          requestID request_id_switch_mode
                     --      }
                     --  } (339,25)
                     ctxt.param_execution_report := (Kind => execution_report_success_PRESENT, execution_report_success => asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type'( successfulStartOfExecutionNotificationNotification => asn1SccSuccessfulStartOfExecutionNotificationNotification_Type'( requestID => asn1Sccrequest_id_switch_mode)));
                     --  report_mode(param_execution_report) (345,25)
                     RIÜreport_mode(ctxt.param_execution_report'Access);
                     --  JOIN Operational_Entry (347,25) at 2073, 1307
                     goto Operational_Entry;
                  end if;
               when CS_Only =>
                  trId := -1;
                  goto next_transition;
               when others =>
                  null;
            end case;
            goto next_transition;
            --  CONNECTION Safe_Entry (39,15)
            <<Safe_Entry>>
            --  switch_thermal(false) (41,13)
            tmp3 := false;
            RIÜswitch_thermal(tmp3'Access);
            --  switch_payload(false) (43,13)
            tmp5 := false;
            RIÜswitch_payload(tmp5'Access);
            --  NEXT_STATE Safe (45,18) at 1120, 2143
            trId := -1;
            ctxt.state := Safe;
            goto next_transition;
            --  CONNECTION Operational_Entry (49,15)
            <<Operational_Entry>>
            --  switch_thermal(true) (51,13)
            tmp7 := true;
            RIÜswitch_thermal(tmp7'Access);
            --  switch_payload(true) (53,13)
            tmp9 := true;
            RIÜswitch_payload(tmp9'Access);
            --  NEXT_STATE Operational (55,18) at 2097, 2165
            trId := -1;
            ctxt.state := Operational;
            goto next_transition;
            --  CONNECTION Idle_Entry (59,15)
            <<Idle_Entry>>
            --  switch_thermal(true) (61,13)
            tmp11 := true;
            RIÜswitch_thermal(tmp11'Access);
            --  switch_payload(false) (63,13)
            tmp13 := false;
            RIÜswitch_payload(tmp13'Access);
            --  NEXT_STATE Idle (65,18) at 1545, 2148
            trId := -1;
            ctxt.state := Idle;
            goto next_transition;
            <<next_transition>>
            null;
         end loop;
      end runTransition;
      

   begin
      runTransition(0);
      ctxt.initDone := True;
end Managemode;