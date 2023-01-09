import ballerina/io;
import wso2healthcare/healthcare.fhir.r4;

r4:Encounter healthcareEncounterExample = {
    id: "123",
    meta: {
        versionId: "abc123"
    },
    identifier: [
    ],
    implicitRules: "https://www.hl7.org/fhir",
    language: "en-US",
    status: "planned",
    'class: {}
};

public type customEncounter record {
    string resourceType;
    string? id;
    record {
        string status;
        string div;
    } text;
    string status;
};

public function encounterTransformStandardToCustom(r4:Encounter healthcareEncounter) returns customEncounter => {
    resourceType: healthcareEncounter.resourceType,
    id: healthcareEncounter.meta.id,
    text: {
        status: let r4:Narrative? narrative = healthcareEncounter.text in narrative is r4:Narrative ? narrative.status : (""),
        div: let r4:Narrative? narrative = healthcareEncounter.text in narrative is r4:Narrative ? narrative.div : ("")
    },
    status: healthcareEncounter.status
};

public function testEncounterTransformation() {
    customEncounter test = encounterTransformStandardToCustom(healthcareEncounterExample);

    io:println(test);
}
