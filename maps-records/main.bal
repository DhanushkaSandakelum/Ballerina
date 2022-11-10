import ballerina/io;

 // @desc - Record (Must be defined within global space)
type Coordinates record {
    int x;
    int y;
};

public function main() {
   Coordinates cord1 = {x: 10, y: 20};

   io:println(`Coordinates => x:${cord1.x} y:${cord1.y}`);
}
