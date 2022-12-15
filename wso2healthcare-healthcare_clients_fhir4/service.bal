import ballerina/http;

service /api/v1 on new http:Listener((8080)) {
    isolated resource function get [string resourceType]/[string id]() returns json {
        return fhirGetById(resourceType, id);
    }

    isolated resource function post .(@http:Payload json payload) returns json {
        return fhirCreate(payload);
    }

    isolated resource function patch .(@http:Payload json payload) returns json {
        return fhirUpdate(payload);
    }

    isolated resource function delete [string resourceType]/[string id]() returns json {
        return fhirDelete(resourceType, id);
    }
}
