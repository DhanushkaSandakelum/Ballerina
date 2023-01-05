import ballerina/io;
import wso2healthcare/healthcare.fhir.r4;

r4:Practitioner healthcarePractitionerExample = {
    id: "123",
    meta: {
        versionId: "abc123"
    },
    identifier: [
    ],
    implicitRules: "https://www.hl7.org/fhir",
    language: "en-US"
};

type customPractitioner record {
    string resourceType;
    string? id;
    record {
        string status;
        string div;
    } text;
    record {
        string system;
        string value;
    }[] identifier;
    boolean? active;
    record {
        string? family;
        string[]? given;
        string[]? prefix;
    }[] name;
    record {
        string use;
        string[]? line;
        string? city;
        string? state;
        string? postalCode;
    }[] address;
};

public function practitionerTransformStandardToCustom(r4:Practitioner healthcarePractitioner) returns customPractitioner => {
    resourceType: healthcarePractitioner.resourceType,
    identifier: let r4:Identifier[]? identifier = healthcarePractitioner.identifier
        in identifier is r4:Identifier[] ? from var identifierItem in identifier
            select {
                system: identifierItem.system.toString(),
                value: identifierItem.value.toString()
            } : ([]),
    name: let r4:HumanName[]? humanName = healthcarePractitioner.name
        in humanName is r4:HumanName[] ? from var nameItem in humanName
            select {
                family: nameItem.family,
                given: nameItem.given,
                prefix: nameItem.prefix
            } : ([]),
    id: healthcarePractitioner.meta.id,
    active: healthcarePractitioner.active,
    address: let r4:Address[]? address = healthcarePractitioner.address
        in address is r4:Address[] ? from var addressItem in address
            select {
                use: addressItem.use.toString(),
                line: addressItem.line,
                city: addressItem.city,
                state: addressItem.state,
                postalCode: addressItem.postalCode
            } : ([]),
    text: {
        status: healthcarePractitioner.text.status,
        div: healthcarePractitioner.text.div
    }
};

public function testPractitionerTransformation() {
    customPractitioner test = practitionerTransformStandardToCustom(healthcarePractitionerExample);

    io:println(test);
}