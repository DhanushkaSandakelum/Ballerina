import ballerina/io;

public function main() {
    // @title - Strings 
    string first_name = "Dhanushka";
    string last_name = "Sandakelum";

    // @desc - String concatination
    io:println(first_name + last_name);

    // @desc - String length
    io:println("Length of first name is " + first_name.length().toString());

    // @desc - String indexes
    io:println(first_name[0]);

    // @desc - String substrings
    io:println(first_name.substring(1, 4));
}
