import ballerina/io;
import ballerina/http;

public function main() returns error? {
    // @desc - Create a new client with a backend URL
    final http:Client clientEndpoint = check new ("http://postman-echo.com");

    // @desc - Send a GET request
    io:println("GET request:");
    json getRes = check clientEndpoint->get("/get?test=123");
    io:println(getRes.toJsonString());

    // @desc - Send a POST request
    io:println("POST request");
    json postRes = check clientEndpoint->post("/post", "POST: Hello");
    io:println(postRes.toJsonString());
}
