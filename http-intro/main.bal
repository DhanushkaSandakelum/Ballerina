import ballerina/http;

// @title - GET REQUESTS
// @desc - GET request standard path - localhost:8000/test
service / on new http:Listener(8080) {
    resource function get test () returns string {
        return "Standard path";
    }
}

// @desc - GET request relative path - localhost:8000/relative/path/test
service / on new http:Listener(8080) {
    resource function get relative/path/test () returns string {
        return "Relative path";
    }
}

// @desc - GET request relative path - localhost:8000/absolute/path/test
service /absolute/path/test on new http:Listener(8080) {
    resource function get . () returns string {
        return "Absolute path";
    }
}