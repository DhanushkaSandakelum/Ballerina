import ballerina/io;

public function main() {
    int[] items = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    int total = 0;
    foreach int x in items {
        total += x;
    }

    io:println("Total is " + total.toString());
}
