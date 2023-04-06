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
function ORU_R01ToPatient(hl7v23:ORU_R01 msg) returns r4:Patient => {
    birthDate: ""
};