import ballerina/io;
import ballerina/log;
import ballerina/time;
import ballerina/sql;
import ballerinax/mysql;

configurable string username = ?;
configurable string password = ?;

type Candidate record {
    int id;
    string first_name;
    string last_name;
    time:Date dob;
};

public function main() returns error? {
    io:println("Started");

   
    time:Date dob = {
        year: 1999,
        month: 11,
        day: 12
    };

    mysql:Client dbClient = check new mysql:Client("localhost", username, password, "bal_db", 3307);


    // // @desc - Insert
    sql:ParameterizedQuery query = `INSERT INTO candidates(first_name, last_name, dob) values('Dhanushka', 'sandakelum', ${dob})`;

    sql:ExecutionResult res = check dbClient->execute(query);

    log:printInfo(string `Result ${res.toBalString()}`);

     // @desc - Read
    int idToBeSearched = 1;

    Candidate candidate = check dbClient->queryRow(`SELECT * FROM candidates WHERE id = ${idToBeSearched}`);

    io:println(string `First name: ${candidate.first_name} Last name: ${candidate.last_name} DOB: ${candidate.dob.toString()}`);

    // @desc - Read many records
    stream<Candidate, sql:Error?> results = dbClient->query(`SELECT * FROM candidates ORDER BY dob DESC LIMIT 5;`);

    check from var result in results do {
        io:println(string `First name: ${result.first_name} Last name: ${result.last_name} DOB: ${result.dob.toString()}`);
    };
}   
