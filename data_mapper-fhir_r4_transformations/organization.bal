import ballerina/io;
import wso2healthcare/healthcare.fhir.r4;

r4:Organization healthcareOrganizationExample = {
    id: "123",
    meta: {
        versionId: "abc123"
    },
    identifier: [
    ],
    implicitRules: "https://www.hl7.org/fhir",
    language: "en-US"
};

type customOrganization record {
    string resourceType;
    string? id;
    string? name;
    string[]? alias;
    record {
        record {
            string? system;
            string? value;
        }[] telecom;
    }[] contact;
    record {
        string? reference;
    }[] endpoint;
};

function organizationTransformStandardToCustom(r4:Organization healthcareOrganization) returns customOrganization => {

    endpoint: let r4:Reference[]? healthcareReference = healthcareOrganization.endpoint
        in healthcareReference is r4:Reference[] ? from var endpointItem in healthcareReference
            select {
                reference: endpointItem.reference
            } : ([]),
    contact: let r4:OrganizationContact[]? healthcareOrganizationContact = healthcareOrganization.contact
                     in healthcareOrganizationContact is r4:OrganizationContact[] ? from var contactItem in healthcareOrganizationContact
                         select {
                             telecom: let r4:ContactPoint[]? healthcareContactPoint = contactItem.telecom
                                 in healthcareContactPoint is r4:ContactPoint[] ? from var contactPointItem in healthcareContactPoint
                                     select {
                                         system: contactPointItem.system,
                                         value: contactPointItem.value
                                     } : ([])
                         } : ([]),
    alias: healthcareOrganization.alias,
    name: healthcareOrganization.name,

    resourceType: healthcareOrganization.resourceType,
    id: healthcareOrganization.id
};

public function testOrganizationTransformation() {
    customOrganization test = organizationTransformStandardToCustom(healthcareOrganizationExample);

    io:println(test);
}

