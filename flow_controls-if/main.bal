import ballerina/io;

public function main() {
    int marks = 74;

    string res = "";

    if(marks >= 75) {
        res = "A";
    } else if(marks >= 50){
        res = "B";
    } else {
        res = "Failed";
    }

    io:println("Your grade is ", res);
}
