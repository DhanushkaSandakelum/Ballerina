import ballerina/io;


// @desc - Tuple need to be always global scope, immutable and holds list of items
type personData [string, int, float];

public function main() {
    personData[] persons = [["Dhanushka", 22, 5.8], ["Janindu", 15, 4.2]];

    foreach var person in persons {
        // @desc - Tuple items can be accessed by indexes
        io:println("Name: " + person[0] + " \tAge: " + person[1].toString() + " Height: " + person[2].toString());
    }

}
