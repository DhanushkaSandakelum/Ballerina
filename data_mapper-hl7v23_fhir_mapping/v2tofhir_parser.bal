

import ballerina/log;

import wso2healthcare/healthcare.hl7;
import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

public function V2ToFHIRParser(string queryMessageStr) returns hl7:HL7Error? {
    byte[] queryMessage = hl7:createHL7WirePayload(queryMessageStr.toBytes());

    hl7:HL7Parser parser = new ();
    hl7:Message|hl7:GenericMessage parsedMsg = check parser.parse(queryMessage);

    // Based on the message type, transformation applied
    if parsedMsg is hl7v23:ADT_A01 {
        // 1). Applying the v2 to fhir transformation for ADT_A01 Message
        r4:Patient patient = ADT_A01ToPatient(parsedMsg);

        log:printInfo(patient.toBalString());
    }
}