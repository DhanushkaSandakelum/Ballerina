import ballerina/io;

public function main() {
   map<int> data = {"first": 1, "second": 2};

   // @desc - Get item
   int? temp = data["first"];
   io:println(temp);

   // @desc - Add item
   data["third"] = 3;

   // Iterate map
   io:println("\nMap items");
   foreach var x in data {
        io:println(x);
   }
}
