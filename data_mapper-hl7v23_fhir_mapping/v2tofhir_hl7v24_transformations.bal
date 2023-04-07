import wso2healthcare/healthcare.hl7v24;
import wso2healthcare/healthcare.fhir.r4;

function HL7V24_ADT_A01ToPatient(hl7v24:ADT_A01 msg) returns r4:Patient => {
    name: GetHL7v24_PID_PatientName(msg.pid.pid5, msg.pid.pid9),             // Done
    birthDate: msg.pid.pid7.ts1,                                             // Done
    gender: GetHL7v24_PID_AdministrativeSex(msg.pid.pid8),                      // Done
    address: GetHL7v24_PID_Address(msg.pid.pid12, msg.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
    telecom: GetHL7v24_PID_PhoneNumber(msg.pid.pid13, msg.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
    communication: GetHL7v24_PID_PrimaryLanguage(msg.pid.pid15),                // Done
    maritalStatus: {
        coding: GetHL7v24_PID_MaritalStatus(msg.pid.pid16)                      // Done
    },
    // extension: GetHL7v24_PID_Religion(msg.pid.pid17)
    identifier: GetHL7v24_PID_SSNNumberPatient(msg.pid.pid19),                  // Done
    extension: GetHL7v24_PID_BirthPlace(msg.pid.pid23),                         // Done
    multipleBirthBoolean: GetHL7v24_PID_MultipleBirthIndicator(msg.pid.pid24),  // Done
    multipleBirthInteger: GetHL7v24_PID_BirthOrder(msg.pid.pid25),              // Done
    deceasedDateTime: msg.pid.pid29.ts1,                                     // Done
    deceasedBoolean: GetHL7v24_PID_PatientDeathIndicator(msg.pid.pid30)         // Done
};

function HL7V24_ADT_A04ToPatient(hl7v24:ADT_A04 msg) returns r4:Patient => {
    name: GetHL7v24_PID_PatientName(msg.pid.pid5, msg.pid.pid9),             // Done
    birthDate: msg.pid.pid7.ts1,                                             // Done
    gender: GetHL7v24_PID_AdministrativeSex(msg.pid.pid8),                      // Done
    address: GetHL7v24_PID_Address(msg.pid.pid12, msg.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
    telecom: GetHL7v24_PID_PhoneNumber(msg.pid.pid13, msg.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
    communication: GetHL7v24_PID_PrimaryLanguage(msg.pid.pid15),                // Done
    maritalStatus: {
        coding: GetHL7v24_PID_MaritalStatus(msg.pid.pid16)                      // Done
    },
    // extension: GetHL7_PID_Religion(msg.pid.pid17)
    identifier: GetHL7v24_PID_SSNNumberPatient(msg.pid.pid19),                  // Done
    extension: GetHL7v24_PID_BirthPlace(msg.pid.pid23),                         // Done
    multipleBirthBoolean: GetHL7v24_PID_MultipleBirthIndicator(msg.pid.pid24),  // Done
    multipleBirthInteger: GetHL7v24_PID_BirthOrder(msg.pid.pid25),              // Done
    deceasedDateTime: msg.pid.pid29.ts1,                                     // Done
    deceasedBoolean: GetHL7v24_PID_PatientDeathIndicator(msg.pid.pid30)         // Done
};

function HL7V24_ORU_R01ToPatient(hl7v24:ORU_R01 msg) returns r4:Patient[] {
    hl7v24:PATIENT_RESULT[] patient_results = msg.patient_result;
    r4:Patient[] patientArr = [];
    foreach hl7v24:PATIENT_RESULT res in patient_results {
        if res.patient.pid is hl7v24:PID {
            r4:Patient patient = HL7V24_PIDToPatient(<hl7v24:PID>res.patient.pid);
            patientArr.push(patient);
        }
    }
    return patientArr;
}


// --- Segment Maps ---
function HL7V24_PIDToPatient(hl7v24:PID pid) returns r4:Patient => {
    name: GetHL7v24_PID_PatientName(pid.pid5, pid.pid9),
    birthDate: pid.pid7.ts1,
    gender: GetHL7v24_PID_AdministrativeSex(pid.pid8),
    address: GetHL7v24_PID_Address(pid.pid12, pid.pid11),
    telecom: GetHL7v24_PID_PhoneNumber(pid.pid13, pid.pid14),
    communication: GetHL7v24_PID_PrimaryLanguage(pid.pid15),
    maritalStatus: {
        coding: GetHL7v24_PID_MaritalStatus(pid.pid16)
    },
    identifier: GetHL7v24_PID_SSNNumberPatient(pid.pid19),
    extension: GetHL7v24_PID_BirthPlace(pid.pid23),
    multipleBirthBoolean: GetHL7v24_PID_MultipleBirthIndicator(pid.pid24),
    multipleBirthInteger: GetHL7v24_PID_BirthOrder(pid.pid25),
    deceasedDateTime: pid.pid29.ts1,
    deceasedBoolean: GetHL7v24_PID_PatientDeathIndicator(pid.pid30)
};