import wso2healthcare/healthcare.clients.fhirr4;

import ballerina/io;
import ballerina/http;

fhirr4:FhirConnectorConfig connectorConfig = {baseURL: "http://hapi.fhir.org/baseR4", mimeType: "application/fhir+json"};
http:ClientConfiguration httpClientConfig = {httpVersion: "2.0"};
string patientFilePath = "./src/fhirResources/response/patient.res.fhir.json";

final fhirr4:FhirConnector fhirConnector = check new fhirr4:FhirConnector(connectorConfig, httpClientConfig);

// FHIR Resources
public type Patient record {|
|};

isolated function sendStandardResponse(int status, string message, json? data = null) returns json {
    json standardResponse = {
            "status": status,
            "message": message,
            "data": data
        };

    return standardResponse;
}

isolated function saveJson(string path, json data) returns io:Error? {
    string jsonOutputPath = path;
    io:Error? res = io:fileWriteJson(jsonOutputPath, data);

    // logging
    if res is () {
        io:println("Resource changes applied at " + path);
    }

    return res;
}

// For GET FHIR Resources
isolated function fhirGetById(fhirr4:ResourceType|string resourceType, string id, fhirr4:MimeType? returnMimeType = null, fhirr4:SummaryType? summary = null) returns json {
    fhirr4:FhirResponse|fhirr4:FhirError fhirResponse = fhirConnector->getById(resourceType, id, returnMimeType, summary);

    if fhirResponse is fhirr4:FhirError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 1. Obtain FHIR resource from the response
    json fhirResource = fhirResponse.'resource.toJson();

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson(patientFilePath, fhirResponse.'resource.toJson());

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource recieved", fhirResource);
}

// TODO: For POST FHIR Resources
isolated function fhirCreate(json|xml data, fhirr4:MimeType? returnMimeType = null, fhirr4:PreferenceType returnPreference = fhirr4:MINIMAL) returns fhirr4:FhirResponse|fhirr4:FhirError {
    return fhirConnector->create(data, returnMimeType, returnPreference);
}

// TODO: For PUT FHIR Resources
isolated function fhirUpdate(json|xml data, fhirr4:MimeType? returnMimeType = null, fhirr4:PreferenceType returnPreference = fhirr4:MINIMAL) returns fhirr4:FhirResponse|fhirr4:FhirError {
    return fhirConnector->update(data, returnMimeType, returnPreference);
}

// For DELETE FHIR Resources
isolated function fhirDelete(fhirr4:ResourceType|string resourceType, string id) returns json {
    fhirr4:FhirResponse|fhirr4:FhirError fhirResponse = fhirConnector->delete(resourceType, id);

    if fhirResponse is fhirr4:FhirError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson(patientFilePath, null);

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource deleted");
}

public function main() {
    io:println("Server running successfully on port 8080");
}
