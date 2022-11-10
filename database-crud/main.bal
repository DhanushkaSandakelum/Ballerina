import ballerina/io;

import ballerinax/mysql;

// Configurations
configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable int port = ?;

public function main() returns error?{
    io:println("Hello, World!");

    // Open connection to the database
    final mysql:Client dbClient = check new mysql:Client(host, username, password, database, port);


    check insertStudents(dbClient);
    check getStudentById(dbClient, 1);
    check getAllStudents(dbClient);
    check deleteStudent(dbClient, 2);
    check updateStudent(dbClient);

    // Close database connection
    check dbClient.close();
}


