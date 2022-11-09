import ballerina/io;

public function main() {
    int[] items = [1, 3, 5, 7, 9];

    io:println("2nd Index: " + items[2].toString());
    io:println("Length: " + items.length().toString());
}