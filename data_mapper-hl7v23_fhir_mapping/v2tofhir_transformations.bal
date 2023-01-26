import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.fhir.r4;

function ADT_A01ToPatient(hl7v23:ADT_A01 adtA01) returns r4:Patient => {
    name: GetHL7_PID_PatientName(adtA01.pid.pid5, adtA01.pid.pid9),             // Done
    birthDate: adtA01.pid.pid7.ts1,                                             // Done
    gender: GetHL7_PID_AdministrativeSex(adtA01.pid.pid8),                      // Done
    address: GetHL7_PID_Address(adtA01.pid.pid12, adtA01.pid.pid11),            // TODO: XAD7 -> Address.ext.iso21090-AD-use && XAD10 -> Address.extension-iso21090-ADXP-censusTract
    telecom: GetHL7_PID_PhoneNumber(adtA01.pid.pid13, adtA01.pid.pid14),        // TODO: ANTLR needs to be added, XTN5 - XTN9 -> ContactPoint.extension need to be mapped
    communication: GetHL7_PID_PrimaryLanguage(adtA01.pid.pid15),                // Done
    maritalStatus: {
        coding: GetHL7_PID_MaritalStatus(adtA01.pid.pid16)                      // Done
    },
    // extension: GetHL7_PID_Religion(adtA01.pid.pid17)
    identifier: GetHL7_PID_SSNNumberPatient(adtA01.pid.pid19),                  // Done
    extension: GetHL7_PID_BirthPlace(adtA01.pid.pid23),                         // Done
    multipleBirthBoolean: GetHL7_PID_MultipleBirthIndicator(adtA01.pid.pid24),  // Done
    multipleBirthInteger: GetHL7_PID_BirthOrder(adtA01.pid.pid25),              // Done
    deceasedDateTime: adtA01.pid.pid29.ts1,                                     // Done
    deceasedBoolean: GetHL7_PID_PatientDeathIndicator(adtA01.pid.pid30)         // Done
};
