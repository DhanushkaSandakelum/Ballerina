import ballerina/io;
import wso2healthcare/healthcare.fhir.r4;

r4:Observation healthcareObservationExample = {
    id: "123",
    meta: {
        versionId: "abc123"
    },
    identifier: [
    ],
    implicitRules: "https://www.hl7.org/fhir",
    language: "en-US",
    status: "preliminary",
    code: {}
};

public type customObservation record {
    string resourceType;
    string? id;
    record {
        string status;
        string div;
    } text;
    string status;
};

public function observationTransformStandardToCustom(r4:Observation healthcareObservation) returns customObservation => {
    resourceType: healthcareObservation.resourceType,
    id: healthcareObservation.meta.id,
    text: {
        status: let r4:Narrative? narrative = healthcareObservation.text in narrative is r4:Narrative ? narrative.status : (""),
        div: let r4:Narrative? narrative = healthcareObservation.text in narrative is r4:Narrative ? narrative.div : ("")
    },
    status: healthcareObservation.status
};

public function testObservationTransformation() {
    customObservation test = observationTransformStandardToCustom(healthcareObservationExample);

    io:println(test);
}
