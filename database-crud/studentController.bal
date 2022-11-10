import ballerina/io;
import ballerina/time;
import ballerina/log;

import ballerina/sql;
import ballerinax/mysql;

public type Student record {|
    int id;
    @sql:Column {name: "first_name"}
    string firstName;
    @sql:Column {name: "last_name"}
    string lastName;
    string? email;
    time:Date dob;
|};

public function hello() {
    io:println("Hello");
}

// @title - INSERT
public function insertStudents(mysql:Client dbClient) returns error? {
    Student[] students = [
        {
            id: -1,
            firstName: "Dhanushka",
            lastName: "Sandakelum",
            email: "dhanushka@gmail.com",
            dob: {year: 1999, month: 11, day: 12}
        },
        {
            id: -1,
            firstName: "Asela",
            lastName: "Perera",
            email: "asela@gmail.com",
            dob: {year: 1999, month: 9, day: 3}
        },
        {
            id: -1,
            firstName: "Deneth",
            lastName: "Pathirage",
            email: "deneth@gmail.com",
            dob: {year: 1998, month: 1, day: 18}
        }
    ];

    sql:ParameterizedQuery[] queries = from Student student in students select 
        `INSERT INTO student(first_name, last_name, email, dob) VALUES (${student.firstName}, ${student.lastName}, ${student.email}, ${student.dob})`;

    sql:ExecutionResult[] results = check dbClient->batchExecute(queries);

    check from sql:ExecutionResult result in results do {
        log:printInfo(result.toBalString());
    };
}

// @title - READ
public function getStudentById(mysql:Client dbClient, int id) returns error? {
    Student student = check dbClient->queryRow(`SELECT * FROM student WHERE id = ${id}`);

    io:println("\nSTUDENT DATA");
    io:println(`First name: ${student.firstName} Last name: ${student.lastName} email: ${student.email} DOB: ${student.dob}`);
}

// @title - READ ALL
public function getAllStudents(mysql:Client dbClient) returns error?{
    sql:ParameterizedQuery query = `SELECT * FROM student`;

    stream<Student, error?> students = dbClient->query(query);

    io:println("\nALL STUDENTS");
    check from Student student in students do {
        io:println(`First name: ${student.firstName} Last name: ${student.lastName} email: ${student.email} DOB: ${student.dob}`);
    };
}

// @title - READ ALL
public function deleteStudent(mysql:Client dbClient, int id) returns error? {
    sql:ExecutionResult res = check dbClient->execute(`DELETE FROM student WHERE id = ${id}`);

    int? affectedRowCount = res.affectedRowCount;

    if affectedRowCount is int {
        io:println(`Deleted row count: ${affectedRowCount}`);
    } else {
        log:printInfo("Unable to obtain affected row count");
    }
}

// @title - UPDATE
public function updateStudent(mysql:Client dbClient) returns error? {
    Student student = {
        id: 3,
        firstName: "Divanjana",
        lastName: "disala",
        email: "divanjana@gmail.com",
        dob: {year: 1999, month: 6, day: 17}
    };

    sql:ExecutionResult res = check dbClient->execute(`UPDATE student SET first_name = ${student.firstName}, last_name = ${student.lastName}, email = ${student.email}, dob = ${student.dob} WHERE id = ${student.id}`);

    int|string? updatedId = res.lastInsertId;

    if updatedId is int {
        io:println(`Updated to row: ${updatedId}`);
    } else {
         log:printInfo("Unable to obtain updated row");
    }
}