import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

// --- Segment Maps ---
function HL7V23_PIDToPatient(hl7v23:PID pid) returns r4:Patient => {
    name: GetHL7v23_PID_PatientName(pid.pid5, pid.pid9),
    birthDate: pid.pid7.ts1,
    gender: GetHL7v23_PID_AdministrativeSex(pid.pid8),
    address: GetHL7v23_PID_Address(pid.pid12, pid.pid11),
    telecom: GetHL7v23_PID_PhoneNumber(pid.pid13, pid.pid14),
    communication: GetHL7v23_PID_PrimaryLanguage(pid.pid15),
    maritalStatus: {
        coding: GetHL7v23_PID_MaritalStatus(pid.pid16)
    },
    identifier: GetHL7v23_PID_SSNNumberPatient(pid.pid19),
    extension: GetHL7v23_PID_BirthPlace(pid.pid23),
    multipleBirthBoolean: GetHL7v23_PID_MultipleBirthIndicator(pid.pid24),
    multipleBirthInteger: GetHL7v23_PID_BirthOrder(pid.pid25),
    deceasedDateTime: pid.pid29.ts1,
    deceasedBoolean: GetHL7v23_PID_PatientDeathIndicator(pid.pid30)
};



