import ballerina/io;

public function main() {
    io:println("Patient Test");
    testPatientTransformation();

    io:println("Organization Test");
    testOrganizationTransformation();

     io:println("Practitioner Test");
    testPractitionerTransformation();
}
