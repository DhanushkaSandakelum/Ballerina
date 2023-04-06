
import ballerina/log;

import wso2healthcare/healthcare.hl7;
import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

public function V2ToFHIRParser(string queryMessageStr) {
    byte[] queryMessage = hl7:createHL7WirePayload(queryMessageStr.toBytes());

    hl7:HL7Parser parser = new ();
    do {
        hl7:Message|hl7:GenericMessage parsedMsg = check parser.parse(queryMessage);

        // Based on the message type, transformation applied
        if parsedMsg is hl7v23:ADT_A01 {
            // 1). Applying the v2 to fhir transformation for ADT_A01 Message
            r4:Patient patient = ADT_A01ToPatient(parsedMsg);

            log:printInfo("Parsing ADT_A01");
            log:printInfo(patient.toBalString());
        } else if parsedMsg is hl7v23:ADT_A04 {
            // 2). Applying the v2 to fhir transformation for ADT_A04 Message
            r4:Patient patient = ADT_A04ToPatient(parsedMsg);

            log:printInfo("Parsing ADT_A04");
            log:printInfo(patient.toBalString());
        } else if parsedMsg is hl7v23:ORU_R01 {
            // 3). Applying the v2 to fhir transformation for ORU_R01 Message
            r4:Patient patient = ORU_R01ToPatient(parsedMsg);

            log:printInfo("Parsing ORU_R01");
            log:printInfo(patient.toBalString());
        } else {
            log:printInfo("Parsing not found");
        }
    } on fail var e {
        log:printError(e.toBalString());
    }

}
