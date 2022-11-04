import ballerina/io;

public function main() {
    int[] items = [1, 2, 3, 4, 5, 6, 7, 8, 9];

    int i = 0;
    int total = 0;
    while i < items.length(){
        total += items[i];
        i = i + 1;
    }

    io:println("Total is " + total.toString());
}