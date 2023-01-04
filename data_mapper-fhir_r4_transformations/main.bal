import ballerina/io;
import wso2healthcare/healthcare.clients.fhirr4;
import ballerina/http;

fhirr4:FHIRConnectorConfig connectorConfig = {baseURL: "http://hapi.fhir.org/baseR4", mimeType: "application/fhir+json"};
http:ClientConfiguration httpClientConfig = {httpVersion: "2.0"};

final fhirr4:FHIRConnector fhirConnector = check new fhirr4:FHIRConnector(connectorConfig, httpClientConfig);

isolated function sendStandardResponse(int status, string message, json? data = null) returns json {
    json standardResponse = {
            "status": status,
            "message": message,
            "data": data
        };

    return standardResponse;
}

// For GET FHIR Resources
isolated function fhirGetById(fhirr4:ResourceType|string resourceType, string id, fhirr4:MimeType? returnMimeType = null, fhirr4:SummaryType? summary = null) returns json {
    fhirr4:FHIRResponse|fhirr4:FHIRError fhirResponse = fhirConnector->getById(resourceType, id, returnMimeType, summary);

    if fhirResponse is fhirr4:FHIRError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 1. Obtain FHIR resource from the response
    json fhirResource = fhirResponse.'resource.toJson();

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource recieved", fhirResource);
}


public function main() {
    // json|error readJson = io:fileReadJson("./src/resources/patient.fhir.json");

    // if readJson is json {
    //     io:println(readJson);
    // } else {
    //     io:println("Some error occured");
    // }

    testPatientTransformation();

    io:println("Server running successfully on port 8080");
}
