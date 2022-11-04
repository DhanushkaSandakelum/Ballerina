import ballerina/io;

public function main() {
    // @title - Integers
    int count = 10;
    io:println(count);

    // @title - Floats
    float degree = 8.3;
    float total = degree + <float> count; // Type casting required - In Ballerina no implicit type conversion
    io:println(total);

    // @title - Boolean
    boolean isRequired = true;

    // @desc - Using ternary operators
    string res = isRequired ? "Required" : "Not required";
    io:println(res);

    // @desc - Using if condition
    if isRequired {
        io:println("Required");
    } else {
        io:println("Not required");
    }

}
