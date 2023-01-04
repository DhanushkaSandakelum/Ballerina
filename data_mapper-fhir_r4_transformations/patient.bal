
import ballerina/io;
import wso2healthcare/healthcare.fhir.r4;

r4:Patient healthcarePatientExample = {
    id: "123",
    meta: {
        versionId: "abc123"
    },
    identifier: [
    ],
    implicitRules: "https://www.hl7.org/fhir",
    language: "en-US"
};

type customPatient record {
    string resourceType;
    string? id;
    boolean? active;
    record {
        string? use;
        string? family;
        string[]? given;
    }[] name;
    record {
        string? use;
        string? system?;
        string? value?;
        int? rank?;
    }[] telecom;
    string? gender;
    string? birthDate;
};

function patientTransformStandardToCustom(r4:Patient healthcarePatient) returns customPatient => {
    resourceType: healthcarePatient.resourceType,
    id: healthcarePatient.id,
    active: healthcarePatient.active,
    gender: healthcarePatient.gender,
    birthDate: healthcarePatient.birthDate,
    telecom: let r4:ContactPoint[]? contactPoint = healthcarePatient.telecom
        in contactPoint is r4:ContactPoint[] ? from var telecomItem in contactPoint
            select {
                use: telecomItem.use,
                system: telecomItem.system,
                value: telecomItem.value,
                rank: telecomItem.rank
            } : ([]),
    name: let r4:HumanName[]? humanName = healthcarePatient.name
        in humanName is r4:HumanName[] ? from var nameItem in humanName
            select {
                use: nameItem.use,
                family: nameItem.family,
                given: nameItem.given
            } : ([])
};

public function testPatientTransformation() {
    customPatient test = patientTransformStandardToCustom(healthcarePatientExample);

    io:println(test);
}
