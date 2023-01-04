import ballerina/http;

service /api/patient on new http:Listener(8080){
    isolated resource function get [string id] () returns json {
        return fhirGetById("Patient", id);
    }
}