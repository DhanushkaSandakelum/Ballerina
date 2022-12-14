import ballerina/http;

import wso2healthcare/healthcare.clients.fhirr4;


service /api/v1 on new http:Listener((8080)) {
    isolated resource function get [string resourceType]/[string id]() returns json {
        return fhirGetById(resourceType, id);
    }

    isolated resource function post [string resourceType](@http:Payload json payload) returns fhirr4:FhirResponse|fhirr4:FhirError {
        return fhirCreate(payload);
    }

    isolated resource function patch [string resourceType](@http:Payload json payload) returns fhirr4:FhirResponse|fhirr4:FhirError {
        return fhirUpdate(payload);
    }

    isolated resource function delete [string resourceType]/[string id]() returns json {
        return fhirDelete(resourceType, id);
    }
}
