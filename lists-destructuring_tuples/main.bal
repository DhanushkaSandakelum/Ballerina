import ballerina/io;


// @desc - Tuple need to be always global scope, immutable and holds list of items
type personData [string, int, float];

public function main() {
    personData[] persons = [["Dhanushka", 22, 5.8], ["Janindu", 15, 4.2]];

    foreach var [name, age, height] in persons {
        // @desc - Tuple items can be accessed by indexes
        io:println(`Name: ${name} Age: ${age} Height: ${height}`);
    }
}
