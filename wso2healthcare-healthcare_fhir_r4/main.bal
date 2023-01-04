import wso2healthcare/healthcare.fhir.r4;
import ballerina/io;
import ballerina/log;
import ballerina/time;
import wso2healthcare/healthcare.fhir.r4.parser;

function getJsonFile(string jsonPath) returns json|error {
    json readJson = check io:fileReadJson(jsonPath);

    io:println("READ JSON");
    return readJson;
}

function setJsonFile(string jsonPath, json data) {
    io:Error? res = io:fileWriteJson(jsonPath, data);

    if res is () {
        io:println("WRITE JSON");
    } else {
        log:printError("Error occured while writing json: " + res.message(), res);
    }
}

function parseJsonFHIRToFHIR(json jsonFHIR) returns r4:Patient {
    do {
        anydata parserResult = check parser:parse(jsonFHIR, r4:Patient);

        r4:Patient patientModel = check parserResult.ensureType();

        return patientModel;
    } on fail error parseError {
        log:printError("Error occured while parsing: " + parseError.message(), parseError);
    }
}

function createJsonFHIRFromFHIR(r4:Patient patient) returns json {
    r4:FHIRResourceEntity fhirEntity = new (patient);
    // Serialize FHIR resource record to Json payload
    json|r4:FHIRSerializerError jsonResult = fhirEntity.toJson();
    if jsonResult is json {
        log:printInfo("Patient resource JSON payload : " + jsonResult.toString());
        return jsonResult;
    } else {
        log:printError("Error occurred while serializing to JSON payload : " + jsonResult.message(), jsonResult);
    }
}

public function main() returns error? {
    // 1) Parse JSON FHIR resource to FHIR resource model
    io:println("1) Parse JSON FHIR resource to FHIR resource model");
    json readRes = check getJsonFile("./data/in/Patient.json");

    r4:Patient patientResource = parseJsonFHIRToFHIR(readRes);
    io:println(patientResource.name.toString());

    // 2) Creating a FHIR Resource models and serializing to JSON wire formats
    io:println("2) Creating a FHIR Resource models and serializing to JSON wire formats");
    r4:Patient patient = {
        meta: {
            lastUpdated: time:utcToString(time:utcNow()),
            profile: [r4:PROFILE_BASE_PATIENT]
        },
        active: true,
        name: [{
            family: "Doe",
            given: ["Jhon"],
            use: r4:official,
            prefix: ["Mr"]
        }],
        address: [{
            line: ["652 S. Lantern Dr."],
            city: "New York",
            country: "United States",
            postalCode: "10022",
            'type: r4:physical,
            use: r4:home
        }]
    };

    json res = createJsonFHIRFromFHIR(patient);
    setJsonFile("./data/out/Patient.json", res);

    io:println(res.toString());
}
