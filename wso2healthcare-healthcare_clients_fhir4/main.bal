import wso2healthcare/healthcare.clients.fhirr4;

import ballerina/io;
import ballerina/http;

fhirr4:FhirConnectorConfig connectorConfig = {baseURL: "http://hapi.fhir.org/baseR4/Patient", mimeType: "application/fhir+json"};

http:ClientConfiguration httpClientConfig = {httpVersion: "2.0"};

final fhirr4:FhirConnector fhirConnector = check new fhirr4:FhirConnector(connectorConfig, httpClientConfig);

// FHIR Resources
public type Patient record {|
|};

// For GET FHIR Resources
isolated function fhirGetById(fhirr4:ResourceType|string resourceType, string id, fhirr4:MimeType? returnMimeType = null, fhirr4:SummaryType? summary = null) returns fhirr4:FhirResponse|fhirr4:FhirError {
    return fhirConnector->getById("", id);
}

// For GET FHIR Resources
isolated function fhirCreate(json|xml data, fhirr4:MimeType? returnMimeType = null,fhirr4:PreferenceType returnPreference = fhirr4:MINIMAL) returns fhirr4:FhirResponse|fhirr4:FhirError {
    return fhirConnector->create(data, returnMimeType, returnPreference);
}

public function main() {
    io:println("Server running successfully");
}
