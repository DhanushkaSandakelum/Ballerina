import ballerina/io;
// import ballerina/log;
import wso2healthcare/healthcare.hl7v23;

import wso2healthcare/healthcare.fhir.r4;

function ADT_A01ToPatient(hl7v23:ADT_A01 adtA01) returns r4:Patient => {
    gender: getFHIR_r4_gender(adtA01.pid.pid8),
    birthDate: adtA01.pid.pid7.ts1,
    multipleBirthBoolean: getFHIR_r4_multipleBirthBoolean(adtA01.pid.pid24)

};

public function main() {
    io:println("Concept map -> Segment PID to Patient Map");
}

