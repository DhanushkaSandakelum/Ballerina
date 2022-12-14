import ballerina/http;
service /api/fhir on new http:Listener(9090) {
    resource function post patient (@http:Payload AccountDetails accountDetails) returns AbstractDetails | error? {
        return fhirTransform(accountDetails);
    }
}