import ballerina/io;
// import ballerina/log;
import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7;

import wso2healthcare/healthcare.fhir.r4;

function parseHL7QueryMessageToJson(string data) returns json|hl7:HL7Error? {
    string queryMessageStr = data;

    // Wrap the above sample HL7 message with essential HL7 message Start Block character (1 byte)ASCII , i.e., <0x0B> 
    // and End Block character (1 byte)ASCII , i.e., <0x1C>
    byte[] queryMessage = hl7:createHL7WirePayload(queryMessageStr.toBytes());

    hl7:HL7Parser parser = new ();
    hl7:Message|hl7:GenericMessage parsedMsg = check parser.parse(queryMessage);

    // Check whther the parsedMsg is Patient record or not
    if parsedMsg is hl7v23:QRY_A19 {
        // log:printInfo(parsedMsg.toString());
        // log:printInfo("Query ID : " + parsedMsg.qrd.qrd4);

        return parsedMsg.toJson();
    } else {
        return error("Message is not in the patient type");
    }
}

function parseJsonToFHIRPatient(json data) returns r4:Patient|error? {
    do {
        anydata parsedResult = check r4:parse(data, r4:Patient);

        r4:Patient patientModel = check parsedResult.ensureType();

        return patientModel;
    } on fail error parseError {
        return error("Parsing to FHIR r4 failed" + parseError.message(), parseError);
    }
}

json patientPayload = {
        "resourceType": "Patient",
        "id": "1",
        "meta": {
            "profile": [
                "http://hl7.org/fhir/StructureDefinition/Patient"
            ]
        },
        "active": true,
        "name": [
            {
                "use": "official",
                "family": "Chalmers",
                "given": [
                    "Peter",
                    "James"
                ]
            }
        ],
        "gender": "male",
        "birthDate": "1974-12-25",
        "managingOrganization": {
            "reference": "Organization/1"
        }
    };

public function main() returns error? {
    // HL7v2.3 Parsing and obtain the message
    // string queryMessageStr = "MSH|^~\\&|ADT1|MCM|LABADT|MCM||SECURITY|QRY^A19|MSG00001|P|2.3|||||||\r"
    //                         + "QRD|20220828104856+0000|R|I|QueryID01|||5.0|1^ADAM^EVERMAN^^|VXI|SIIS|";

    string patientStr = "MSH|^~\\&|EPIC|EPICADT|SMS|SMSADT|199912271408|CHARRIS|ADT^A04|1817457|D|2.5|\r" +
    "PID||0493575^^^2^ID 1|454721||DOE^JOHN^^^^|DOE^JOHN^^^^|19480203|M||B|254 MYSTREET AVE^^MYTOWN^OH^44123^USA||(216)123-4567|||M|NON|400003403~1129086|";

    json|hl7:HL7Error? hl7ParsedMsg = parseHL7QueryMessageToJson(patientStr);

    io:println("HL7 Patient");
    io:println(hl7ParsedMsg);

    // FHIR r4 Parsing and construct the fhir patient
    r4:Patient|error? fhirPatient = parseJsonToFHIRPatient(patientPayload);

    io:println("FHIR r4 Patient");
    io:println(fhirPatient);
}
