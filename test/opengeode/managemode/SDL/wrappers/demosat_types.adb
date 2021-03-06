-- Code automatically generated by asn1scc tool
pragma Warnings (Off, "redundant with clause in body");

pragma Warnings (Off, "no entities of ""PUS_C"" are referenced");
pragma Warnings (Off, "use clause for package ""PUS_C"" has no effect");
pragma Warnings (Off, "unit ""PUS_C"" is not referenced");
WITH PUS_C;
pragma Warnings (On, "no entities of ""PUS_C"" are referenced");
pragma Warnings (On, "use clause for package ""PUS_C"" has no effect");
pragma Warnings (On, "unit ""PUS_C"" is not referenced");

pragma Warnings (On, "redundant with clause in body");

pragma Warnings (Off, "use clause for type");
pragma Warnings (Off, "is already use-visible through previous use_type_clause at");
use type PUS_C.asn1SccUINT8T;
use type PUS_C.asn1SccSATELLITE_MODE;
use type PUS_C.asn1SccVOLTAGE;
use type PUS_C.asn1SccTEMPERATURE;
use type PUS_C.asn1SccPI_COEFFICIENT;
use type PUS_C.asn1SccDUTY_CYCLE;
use type PUS_C.asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type;
use type PUS_C.asn1SccSuccessfulStartOfExecutionNotificationNotification_Type;
use type PUS_C.asn1SccREQUEST_ID;
use type PUS_C.asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type;
use type PUS_C.asn1SccFailedStartOfExecutionNotificationNotification_Type;
use type PUS_C.asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_address;
use type PUS_C.asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_mode;
use type PUS_C.asn1SccFAILURE_NOTICE_DATA_failure_notice_code_invalid_state;
use type PUS_C.asn1SccFAILURE_NOTICE_DATA;
pragma Warnings (On, "use clause for type");
pragma Warnings (On, "is already use-visible through previous use_type_clause at");


PACKAGE BODY DemoSat_Types with SPARK_Mode IS




pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccPAYLOAD_HK_DATA_Equal(val1, val2: in asn1SccPAYLOAD_HK_DATA)
    return Boolean 
is
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : Boolean := TRUE;
    pragma Warnings (On, "initialization of ret has no effect");        

begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
    ret := (val1.payload_enabled = val2.payload_enabled);

    if ret then
        ret := (val1.payload_data_enabled = val2.payload_data_enabled);

        if ret then
            ret := (val1.payload_data = val2.payload_data);

        end if;
    end if;
	return ret;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccPAYLOAD_HK_DATA_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccPAYLOAD_HK_DATA_Init return asn1SccPAYLOAD_HK_DATA
is
    val: asn1SccPAYLOAD_HK_DATA;
begin

    --set payload_enabled 
    val.payload_enabled := FALSE;
    --set payload_data_enabled 
    val.payload_data_enabled := FALSE;
    --set payload_data 
    val.payload_data := PUS_C.asn1SccUINT8T_Init;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccPAYLOAD_HK_DATA_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccPAYLOAD_HK_DATA_IsConstraintValid(val : in asn1SccPAYLOAD_HK_DATA) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret := PUS_C.asn1SccUINT8T_IsConstraintValid(val.payload_data);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccPAYLOAD_HK_DATA_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccMODE_HK_DATA_Equal(val1, val2: in asn1SccMODE_HK_DATA)
    return Boolean 
is
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : Boolean := TRUE;
    pragma Warnings (On, "initialization of ret has no effect");        

begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
    ret := (val1.mode = val2.mode);

    if ret then
        ret := (adaasn1rtl.Asn1Real_Equal(val1.input_voltage, val2.input_voltage));

    end if;
	return ret;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccMODE_HK_DATA_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccMODE_HK_DATA_Init return asn1SccMODE_HK_DATA
is
    val: asn1SccMODE_HK_DATA;
begin

    --set mode 
    val.mode := PUS_C.asn1SccSATELLITE_MODE_Init;
    --set input_voltage 
    val.input_voltage := PUS_C.asn1SccVOLTAGE_Init;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccMODE_HK_DATA_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccMODE_HK_DATA_IsConstraintValid(val : in asn1SccMODE_HK_DATA) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret := PUS_C.asn1SccSATELLITE_MODE_IsConstraintValid(val.mode);
    if ret.Success then
        ret := PUS_C.asn1SccVOLTAGE_IsConstraintValid(val.input_voltage);
    end if;
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccMODE_HK_DATA_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccTHERMAL_HK_DATA_Equal(val1, val2: in asn1SccTHERMAL_HK_DATA)
    return Boolean 
is
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : Boolean := TRUE;
    pragma Warnings (On, "initialization of ret has no effect");        

begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
    ret := (val1.thermal_enabled = val2.thermal_enabled);

    if ret then
        ret := (adaasn1rtl.Asn1Real_Equal(val1.current_temperature, val2.current_temperature));

        if ret then
            ret := (adaasn1rtl.Asn1Real_Equal(val1.target_temperature, val2.target_temperature));

            if ret then
                ret := (adaasn1rtl.Asn1Real_Equal(val1.pi_integral, val2.pi_integral));

                if ret then
                    ret := (adaasn1rtl.Asn1Real_Equal(val1.thermal_duty_cycle, val2.thermal_duty_cycle));

                end if;
            end if;
        end if;
    end if;
	return ret;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccTHERMAL_HK_DATA_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccTHERMAL_HK_DATA_Init return asn1SccTHERMAL_HK_DATA
is
    val: asn1SccTHERMAL_HK_DATA;
begin

    --set thermal_enabled 
    val.thermal_enabled := FALSE;
    --set current_temperature 
    val.current_temperature := PUS_C.asn1SccTEMPERATURE_Init;
    --set target_temperature 
    val.target_temperature := PUS_C.asn1SccTEMPERATURE_Init;
    --set pi_integral 
    val.pi_integral := PUS_C.asn1SccPI_COEFFICIENT_Init;
    --set thermal_duty_cycle 
    val.thermal_duty_cycle := PUS_C.asn1SccDUTY_CYCLE_Init;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccTHERMAL_HK_DATA_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccTHERMAL_HK_DATA_IsConstraintValid(val : in asn1SccTHERMAL_HK_DATA) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret := PUS_C.asn1SccTEMPERATURE_IsConstraintValid(val.current_temperature);
    if ret.Success then
        ret := PUS_C.asn1SccTEMPERATURE_IsConstraintValid(val.target_temperature);
        if ret.Success then
            ret := PUS_C.asn1SccPI_COEFFICIENT_IsConstraintValid(val.pi_integral);
            if ret.Success then
                ret := PUS_C.asn1SccDUTY_CYCLE_IsConstraintValid(val.thermal_duty_cycle);
            end if;
        end if;
    end if;
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccTHERMAL_HK_DATA_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccEXECUTION_REPORT_Equal(val1, val2: in asn1SccEXECUTION_REPORT)
    return Boolean 
is
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : Boolean := TRUE;
    pragma Warnings (On, "initialization of ret has no effect");        

begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
    ret := val1.kind = val2.kind;
    if ret then
        case val1.kind is
            when execution_report_success_PRESENT =>
                ret := PUS_C.asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type_Equal(val1.execution_report_success, val2.execution_report_success);
            when execution_report_failed_PRESENT =>
                ret := PUS_C.asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type_Equal(val1.execution_report_failed, val2.execution_report_failed);
        end case;
    end if;
	return ret;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccEXECUTION_REPORT_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccEXECUTION_REPORT_Init return asn1SccEXECUTION_REPORT
is
    val: asn1SccEXECUTION_REPORT;
begin
    --set execution_report_success 
    declare
        execution_report_success_tmp:PUS_C.asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type;
    begin
        execution_report_success_tmp := PUS_C.asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type_Init;
    	pragma Warnings (Off, "object ""execution_report_success_tmp"" is always False at this point");
        val := asn1SccEXECUTION_REPORT'(kind => execution_report_success_PRESENT, execution_report_success => execution_report_success_tmp);
    	pragma Warnings (On, "object ""execution_report_success_tmp"" is always False at this point");
    end;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccEXECUTION_REPORT_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccEXECUTION_REPORT_IsConstraintValid(val : in asn1SccEXECUTION_REPORT) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    if val.kind = execution_report_success_PRESENT then
    	ret := PUS_C.asn1SccTM_1_3_SuccessfulStartOfExecutionVerificationReport_Type_IsConstraintValid(val.execution_report_success);
    end if;
    if ret.Success then
        if val.kind = execution_report_failed_PRESENT then
        	ret := PUS_C.asn1SccTM_1_4_FailedStartOfExecutionVerificationReport_Type_IsConstraintValid(val.execution_report_failed);
        end if;
    end if;
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccEXECUTION_REPORT_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_REAL_Equal(val1, val2: in asn1SccT_REAL)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return adaasn1rtl.Asn1Real_Equal(val1, val2);

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_REAL_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_REAL_Init return asn1SccT_REAL
is
    val: asn1SccT_REAL;
begin
    val := 0.00000000000000000000E+000;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_REAL_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_REAL_IsConstraintValid(val : in asn1SccT_REAL) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := ((-4.00000000000000000000E+004 <= val) AND (val <= 4.00000000000000000000E+004));
    ret.ErrorCode := (if ret.Success then 0 else ERR_T_REAL);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_REAL_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccTEMPERATURE_DIFFERENCE_Equal(val1, val2: in asn1SccTEMPERATURE_DIFFERENCE)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return adaasn1rtl.Asn1Real_Equal(val1, val2);

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccTEMPERATURE_DIFFERENCE_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccTEMPERATURE_DIFFERENCE_Init return asn1SccTEMPERATURE_DIFFERENCE
is
    val: asn1SccTEMPERATURE_DIFFERENCE;
begin
    val := 0.00000000000000000000E+000;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccTEMPERATURE_DIFFERENCE_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccTEMPERATURE_DIFFERENCE_IsConstraintValid(val : in asn1SccTEMPERATURE_DIFFERENCE) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := ((-2.00000000000000000000E+002 <= val) AND (val <= 2.00000000000000000000E+002));
    ret.ErrorCode := (if ret.Success then 0 else ERR_TEMPERATURE_DIFFERENCE);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccTEMPERATURE_DIFFERENCE_IsConstraintValid;


 

END DemoSat_Types;