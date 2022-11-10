import ballerina/io;

// @desc - File object
public class File {
    string fileName;
    string fileContent;

    function init(string n, string? c) returns error? {
        self.fileName = n;
        self.fileContent = check c.ensureType(string);
        return;
    }    
}

public function main() returns error?{
    File file1 = check new File("test.txt", "Hi there");

    io:println(file1.fileContent);
}
