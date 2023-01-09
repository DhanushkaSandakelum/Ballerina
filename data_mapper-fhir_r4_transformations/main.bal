import ballerina/io;

public function main() {
    io:println("Patient Test");
    testPatientTransformation();

    io:println("Organization Test");
    testOrganizationTransformation();

    io:println("Practitioner Test");
    testPractitionerTransformation();

    io:println("Encounter Test");
    testEncounterTransformation();
    
    io:println("Observation Test");
    testObservationTransformation();
}
