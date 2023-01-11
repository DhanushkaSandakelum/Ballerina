import ballerina/io;
// import ballerina/log;
import wso2healthcare/healthcare.hl7v23;

import wso2healthcare/healthcare.fhir.r4;

function PIDToPatient(hl7v23:PID pid) returns r4:Patient => {
    // name: pid.pid5 + pid.pid9,
    name:  pid.pid5,
    gender: pid.pid8,
    extension: pid.pid6 + pid.pid17 + pid.pid23 + pid.pid26,
    birthDate: pid.pid7,
    address: pid.pid11 + pid.pid12,
    telecom: pid.pid13 + pid.pid14,
    communication: pid.pid15,
    identifier: pid.pid19 + pid.pid20 + pid.pid2 + pid.pid3 + pid.pid4,
    multipleBirthBoolean: pid.pid24,
    multipleBirthInteger: pid.pid25,
    deceasedBoolean: pid.pid30
};

public function main() {
    io:println("Concept map -> Segment PID to Patient Map");
}
