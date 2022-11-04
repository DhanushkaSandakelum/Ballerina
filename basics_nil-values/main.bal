import ballerina/io;

public function main() {
    // @title - NIL 
    // @desc - Same as NULL. Use elvis operator(?) to return nil if the value is nil, else returns the original value
    int? x = ();

    string res = x == () ? "NIL" : x.toString();

    io:println(res);
}
