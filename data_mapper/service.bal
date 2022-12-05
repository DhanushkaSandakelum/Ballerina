import ballerina/http;
service /api on new http:Listener(9000) {
    resource function post student(@http:Payload PersonDetails personDetails) returns StudentDetails | error {
        return transform(personDetails);
    }
}