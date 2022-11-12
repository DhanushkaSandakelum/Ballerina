import ballerina/http;

type Student record {
    string name;
    int age;
};

service / on new http:Listener(8080) {
    // @title - GET REQUESTS
    // @desc - GET request standard path - localhost:8000/test
    resource function get test () returns string {
        return "Standard path";
    }

    // @desc - GET request relative path - localhost:8000/relative/path/test
     resource function get relative/path/test () returns string {
        return "Relative path";
    }

    // @desc - GET request relative path - localhost:8000/absolute/path/test
    resource function get . () returns string {
        return "Absolute path";
    }

    // @title - Path parameters
    // @desc - Consume one parameter
    resource function get user/[string username] () returns string {
        return "Hello, " + username;
    }

    // @title - Path parameters
    // @desc - Consume stream of parameters
    resource function get users/[string... username] () returns string {
        string usernameList = "";

        foreach string name in username {
            usernameList = usernameList + " " + name;
        }

        return "Hello, " + usernameList;
    }

    // @title - REQUEST PARAMETERS
    // @desc - Multiple request params
    resource function get details (string first_name, int age) returns string {
        return "Hello, " + first_name + " and you are " + age.toString() + " years old.";
    }

    // @title - PAYLOAD REQUESTS
    // @desc - post payload
    resource function post setStudent (@http:Payload Student student) returns string {
        return student.name + student.age.toString();        
    }
}