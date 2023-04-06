import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

function ADT_A01ToPatient(hl7v23:ADT_A01 msg) returns r4:Patient => {
    name: GetHL7_PID_PatientName(msg.pid.pid5, msg.pid.pid9),             // Done
    birthDate: msg.pid.pid7.ts1,                                             // Done
    gender: GetHL7_PID_AdministrativeSex(msg.pid.pid8),                      // Done
    address: GetHL7_PID_Address(msg.pid.pid12, msg.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
    telecom: GetHL7_PID_PhoneNumber(msg.pid.pid13, msg.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
    communication: GetHL7_PID_PrimaryLanguage(msg.pid.pid15),                // Done
    maritalStatus: {
        coding: GetHL7_PID_MaritalStatus(msg.pid.pid16)                      // Done
    },
    // extension: GetHL7_PID_Religion(msg.pid.pid17)
    identifier: GetHL7_PID_SSNNumberPatient(msg.pid.pid19),                  // Done
    extension: GetHL7_PID_BirthPlace(msg.pid.pid23),                         // Done
    multipleBirthBoolean: GetHL7_PID_MultipleBirthIndicator(msg.pid.pid24),  // Done
    multipleBirthInteger: GetHL7_PID_BirthOrder(msg.pid.pid25),              // Done
    deceasedDateTime: msg.pid.pid29.ts1,                                     // Done
    deceasedBoolean: GetHL7_PID_PatientDeathIndicator(msg.pid.pid30)         // Done
};

function ADT_A04ToPatient(hl7v23:ADT_A04 msg) returns r4:Patient => {
    name: GetHL7_PID_PatientName(msg.pid.pid5, msg.pid.pid9),             // Done
    birthDate: msg.pid.pid7.ts1,                                             // Done
    gender: GetHL7_PID_AdministrativeSex(msg.pid.pid8),                      // Done
    address: GetHL7_PID_Address(msg.pid.pid12, msg.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
    telecom: GetHL7_PID_PhoneNumber(msg.pid.pid13, msg.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
    communication: GetHL7_PID_PrimaryLanguage(msg.pid.pid15),                // Done
    maritalStatus: {
        coding: GetHL7_PID_MaritalStatus(msg.pid.pid16)                      // Done
    },
    // extension: GetHL7_PID_Religion(msg.pid.pid17)
    identifier: GetHL7_PID_SSNNumberPatient(msg.pid.pid19),                  // Done
    extension: GetHL7_PID_BirthPlace(msg.pid.pid23),                         // Done
    multipleBirthBoolean: GetHL7_PID_MultipleBirthIndicator(msg.pid.pid24),  // Done
    multipleBirthInteger: GetHL7_PID_BirthOrder(msg.pid.pid25),              // Done
    deceasedDateTime: msg.pid.pid29.ts1,                                     // Done
    deceasedBoolean: GetHL7_PID_PatientDeathIndicator(msg.pid.pid30)         // Done
};

// DUMMRY FUNCTION 
// @TODO - Should be mapped
// function ORU_R01ToPatient(hl7v23:ORU_R01 msg) returns r4:Patient => {
//     name: GetHL7_PID_PatientName(msg.response[0].patient.pid.pid5, msg.response[0].patient.pid.pid9),             // Done
//     birthDate: msg.response[0].patient.pid.pid7.ts1,                                             // Done
//     gender: GetHL7_PID_AdministrativeSex(msg.response[0].patient.pid.pid8),                      // Done
//     address: GetHL7_PID_Address(msg.response[0].patient.pid.pid12, msg.response[0].patient.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
//     telecom: GetHL7_PID_PhoneNumber(msg.response[0].patient.pid.pid13, msg.response[0].patient.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
//     communication: GetHL7_PID_PrimaryLanguage(msg.response[0].patient.pid.pid15),                // Done
//     maritalStatus: {
//         coding: GetHL7_PID_MaritalStatus(msg.response[0].patient.pid.pid16)                      // Done
//     },
//     // extension: GetHL7_PID_Religion(msg.pid.pid17)
//     identifier: GetHL7_PID_SSNNumberPatient(msg.response[0].patient.pid.pid19),                  // Done
//     extension: GetHL7_PID_BirthPlace(msg.response[0].patient.pid.pid23),                         // Done
//     multipleBirthBoolean: GetHL7_PID_MultipleBirthIndicator(msg.response[0].patient.pid.pid24),  // Done
//     multipleBirthInteger: GetHL7_PID_BirthOrder(msg.response[0].patient.pid.pid25),              // Done
//     deceasedDateTime: msg.response[0].patient.pid.pid29.ts1,                                     // Done
//     deceasedBoolean: GetHL7_PID_PatientDeathIndicator(msg.response[0].patient.pid.pid30)         // Done
// };

function ORU_R01ToPatient(hl7v23:ORU_R01 msg) returns r4:Patient[] {
    hl7v23:RESPONSE[] responses = msg.response;
    r4:Patient[] patientArr = [];
    foreach hl7v23:RESPONSE res in responses {
        if res.patient.pid is hl7v23:PID {
            r4:Patient patient = PIDToPatient(<hl7v23:PID>res.patient.pid);
            patientArr.push(patient);
        }
    }
    return patientArr;
}



function PIDToPatient(hl7v23:PID pid) returns r4:Patient => {
    
    name: GetHL7_PID_PatientName(pid.pid5, pid.pid9),
    birthDate: pid.pid7.ts1,
    gender: GetHL7_PID_AdministrativeSex(pid.pid8),
    address: GetHL7_PID_Address(pid.pid12, pid.pid11),
    telecom: GetHL7_PID_PhoneNumber(pid.pid13, pid.pid14),
    communication: GetHL7_PID_PrimaryLanguage(pid.pid15),
    maritalStatus: {
        coding: GetHL7_PID_MaritalStatus(pid.pid16)
    },
    identifier: GetHL7_PID_SSNNumberPatient(pid.pid19),
    extension: GetHL7_PID_BirthPlace(pid.pid23),
    multipleBirthBoolean: GetHL7_PID_MultipleBirthIndicator(pid.pid24),
    multipleBirthInteger: GetHL7_PID_BirthOrder(pid.pid25),
    deceasedDateTime: pid.pid29.ts1,
    deceasedBoolean: GetHL7_PID_PatientDeathIndicator(pid.pid30)
};