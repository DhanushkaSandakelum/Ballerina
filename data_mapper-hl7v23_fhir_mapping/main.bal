import ballerina/io;
import wso2healthcare/healthcare.hl7v23;
import ballerina/log;
import wso2healthcare/healthcare.hl7;
import wso2healthcare/healthcare.fhir.r4;

//hl7v2tofhir package

public function parseV2QueryMessageToFHIR(string queryMessageStr) returns hl7:HL7Error? {
    byte[] queryMessage = hl7:createHL7WirePayload(queryMessageStr.toBytes());

    hl7:HL7Parser parser = new ();
    hl7:Message|hl7:GenericMessage parsedMsg = check parser.parse(queryMessage);

    if parsedMsg is hl7v23:ADT_A01 {
        // log:printInfo(parsedMsg.toBalString());

        // Applying the v2 to fhir transformation
        r4:Patient patient = ADT_A01ToPatient(parsedMsg);

        log:printInfo(patient.toBalString());
    }
}

public function main() returns error? {
    string queryMessageStr = "MSH|^~\\&|SendingApp|SendingFacility|HL7API|PKB|20160102101112||ADT^A01|ABC0000000001|P|2.3\r" +
"PID|||9999999999^^^NHS^NH||Smith^John^Joe^^Mr||19700101|M|||Flat name^1, The Road^London^London^SW1A 1AA^GBR||01234567890^PRN~07123456789^PRS|^NET^john.smith@company.com~01234098765^WPN||||||||||||||||N|\r" +
"PV1|1|I|^^^^^^^^My Ward||||^Jones^Stuart^James^^Dr^|^Smith^William^^^Dr^|^Foster^Terry^^^Mr^||||||||||V00001|||||||||||||||||||||||||201508011000|201508011200";

    io:println("Concept map -> Bundle ADT_A01 to Patient Map");

    return parseV2QueryMessageToFHIR(queryMessageStr);
}

