import wso2healthcare/healthcare.clients.fhirr4;

import ballerina/io;
import ballerina/http;

fhirr4:FHIRConnectorConfig connectorConfig = {baseURL: "http://hapi.fhir.org/baseR4", mimeType: "application/fhir+json"};
http:ClientConfiguration httpClientConfig = {httpVersion: "2.0"};

final fhirr4:FHIRConnector fhirConnector = check new fhirr4:FHIRConnector(connectorConfig, httpClientConfig);

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
    fhirr4:FHIRResponse|fhirr4:FHIRError fhirResponse = fhirConnector->getById(resourceType, id, returnMimeType, summary);

    if fhirResponse is fhirr4:FHIRError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 1. Obtain FHIR resource from the response
    json fhirResource = fhirResponse.'resource.toJson();

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson("./src/fhirResources/response/patient.res.fhir.json", fhirResponse.'resource.toJson());

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource recieved", fhirResource);
}

// TODO: For POST FHIR Resources
isolated function fhirCreate(json|xml data, fhirr4:MimeType? returnMimeType = null, fhirr4:PreferenceType returnPreference = fhirr4:MINIMAL) returns json {
    fhirr4:FHIRResponse|fhirr4:FHIRError fhirResponse = fhirConnector->create(data, returnMimeType, returnPreference);

    if fhirResponse is fhirr4:FHIRError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 1. Obtain FHIR resource from the response
    json fhirResource = fhirResponse.'resource.toJson();

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson("./src/fhirResources/response/patient.res.fhir.json", fhirResponse.'resource.toJson());

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource created", fhirResource);
}

// TODO: For PUT FHIR Resources
isolated function fhirUpdate(json|xml data, fhirr4:MimeType? returnMimeType = null, fhirr4:PreferenceType returnPreference = fhirr4:MINIMAL) returns json {
    fhirr4:FHIRResponse|fhirr4:FHIRError fhirResponse = fhirConnector->update(data, returnMimeType, returnPreference);

    io:println(fhirResponse);

    if fhirResponse is fhirr4:FHIRError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 1. Obtain FHIR resource from the response
    json fhirResource = fhirResponse.'resource.toJson();

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson("./src/fhirResources/response/patient.res.fhir.json", fhirResponse.'resource.toJson());

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource updated", fhirResource);
}

// For DELETE FHIR Resources
isolated function fhirDelete(fhirr4:ResourceType|string resourceType, string id) returns json {
    fhirr4:FHIRResponse|fhirr4:FHIRError fhirResponse = fhirConnector->delete(resourceType, id);

    if fhirResponse is fhirr4:FHIRError {
        return sendStandardResponse(404, "Something went wrong on requesting FHIR resource");
    }

    // 2. Save the resource as a JSON object
    io:Error? res = saveJson("./src/fhirResources/response/patient.res.fhir.json", null);

    if res is io:Error {
        return sendStandardResponse(404, "Something went wrong on writing the file");
    }

    // return fhirResponse;
    return sendStandardResponse(fhirResponse.httpStatusCode, "Resource deleted");
}

public function main() {
    io:println("Server running successfully on port 8080");
}
