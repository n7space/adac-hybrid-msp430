-- Code automatically generated by asn1scc tool
pragma Warnings (Off, "redundant with clause in body");
pragma Warnings (On, "redundant with clause in body");

pragma Warnings (Off, "use clause for type");
pragma Warnings (Off, "is already use-visible through previous use_type_clause at");
pragma Warnings (On, "use clause for type");
pragma Warnings (On, "is already use-visible through previous use_type_clause at");


PACKAGE BODY TASTE_BasicTypes with SPARK_Mode IS




pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_Int32_Equal(val1, val2: in asn1SccT_Int32)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return val1 = val2;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_Int32_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_Int32_Init return asn1SccT_Int32
is
    val: asn1SccT_Int32;
begin
    val := 0;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_Int32_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_Int32_IsConstraintValid(val : in asn1SccT_Int32) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := ((-2147483648 <= val) AND (val <= 2147483647));
    ret.ErrorCode := (if ret.Success then 0 else ERR_T_INT32);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_Int32_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_UInt32_Equal(val1, val2: in asn1SccT_UInt32)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return val1 = val2;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_UInt32_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_UInt32_Init return asn1SccT_UInt32
is
    val: asn1SccT_UInt32;
begin
    val := 0;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_UInt32_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_UInt32_IsConstraintValid(val : in asn1SccT_UInt32) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := (val <= 4294967295);
    ret.ErrorCode := (if ret.Success then 0 else ERR_T_UINT32);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_UInt32_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_Int8_Equal(val1, val2: in asn1SccT_Int8)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return val1 = val2;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_Int8_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_Int8_Init return asn1SccT_Int8
is
    val: asn1SccT_Int8;
begin
    val := 0;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_Int8_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_Int8_IsConstraintValid(val : in asn1SccT_Int8) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := ((-128 <= val) AND (val <= 127));
    ret.ErrorCode := (if ret.Success then 0 else ERR_T_INT8);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_Int8_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_UInt8_Equal(val1, val2: in asn1SccT_UInt8)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return val1 = val2;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_UInt8_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_UInt8_Init return asn1SccT_UInt8
is
    val: asn1SccT_UInt8;
begin
    val := 0;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_UInt8_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_UInt8_IsConstraintValid(val : in asn1SccT_UInt8) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret.Success := (val <= 255);
    ret.ErrorCode := (if ret.Success then 0 else ERR_T_UINT8);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_UInt8_IsConstraintValid;



pragma Warnings (Off, "formal parameter ""val1"" is not referenced");
pragma Warnings (Off, "formal parameter ""val2"" is not referenced");
function asn1SccT_Boolean_Equal(val1, val2: in asn1SccT_Boolean)
    return Boolean 
is
begin
    pragma Warnings (Off, "condition can only be False if invalid values present");        
    pragma Warnings (Off, "condition can only be True if invalid values present");        
	return val1 = val2;

    pragma Warnings (On, "condition can only be False if invalid values present");        
    pragma Warnings (On, "condition can only be True if invalid values present");        
end asn1SccT_Boolean_Equal;
pragma Warnings (On, "formal parameter ""val1"" is not referenced");
pragma Warnings (On, "formal parameter ""val2"" is not referenced");

function asn1SccT_Boolean_Init return asn1SccT_Boolean
is
    val: asn1SccT_Boolean;
begin
    val := FALSE;
	pragma Warnings (Off, "object ""val"" is always");
    return val;
	pragma Warnings (On, "object ""val"" is always");
end asn1SccT_Boolean_Init;

	pragma Warnings (Off, "formal parameter ""val"" is not referenced");
function asn1SccT_Boolean_IsConstraintValid(val : in asn1SccT_Boolean) return adaasn1rtl.ASN1_RESULT
is
	pragma Warnings (On, "formal parameter ""val"" is not referenced");
    pragma Warnings (Off, "initialization of ret has no effect");        
    ret : adaasn1rtl.ASN1_RESULT := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
    pragma Warnings (On, "initialization of ret has no effect");        
begin
	pragma Warnings (Off, "condition can only be False if invalid values present");
	pragma Warnings (Off, "condition can only be True if invalid values present");
    ret := adaasn1rtl.ASN1_RESULT'(Success => true, ErrorCode => 0);
	pragma Warnings (On, "condition can only be False if invalid values present");
	pragma Warnings (On, "condition can only be True if invalid values present");
    return ret;
end asn1SccT_Boolean_IsConstraintValid;


 

END TASTE_BasicTypes;