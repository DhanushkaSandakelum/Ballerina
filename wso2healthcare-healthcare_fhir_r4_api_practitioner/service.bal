import wso2healthcare/healthcare.fhir.r4;
import ballerina/io;
import ballerina/log;
import ballerina/http;

final r4:ResourceAPIConfig apiConfig = {
    resourceType: "Practitioner",
    profiles: [
        "http://hl7.org/fhir/StructureDefinition/Practitioner"
    ],
    defaultProfile: (),
    searchParameters: [
        {
            name: "communication",
            active: true,
            information: {
                description: "One of the languages that the practitioner can communicate with",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Practitioner-communication"
            }
        },
        {
            name: "name",
            active: true,
            information: {
                description: "A server defined search that may match any of the string fields in the HumanName, including family, give, prefix, suffix, suffix, and/or text",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Practitioner-name"
            }
        },
        {
            name: "email",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A value in an email contact",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-email"
            }
        },
        {
            name: "address",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A server defined search that may match any of the string fields in the Address, including line, city, district, state, country, postalCode, and/or text",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address"
            }
        },
        {
            name: "active",
            active: true,
            information: {
                description: "Whether the practitioner record is active",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Practitioner-active"
            }
        },
        {
            name: "address-use",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A use code specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address-use"
            }
        },
        {
            name: "phonetic",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A portion of either family or given name using some kind of phonetic matching algorithm",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-phonetic"
            }
        },
        {
            name: "address-country",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A country specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address-country"
            }
        },
        {
            name: "phone",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A value in a phone contact",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-phone"
            }
        },
        {
            name: "identifier",
            active: true,
            information: {
                description: "A practitioner's Identifier",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Practitioner-identifier"
            }
        },
        {
            name: "address-city",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A city specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address-city"
            }
        },
        {
            name: "gender",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): Gender of the practitioner",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-gender"
            }
        },
        {
            name: "telecom",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): The value in any kind of contact",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-telecom"
            }
        },
        {
            name: "address-state",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A state specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address-state"
            }
        },
        {
            name: "given",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A portion of the given name",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-given"
            }
        },
        {
            name: "address-postalcode",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A postalCode specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-address-postalcode"
            }
        },
        {
            name: "family",
            active: true,
            information: {
                description: "[Practitioner](practitioner.html): A portion of the family name",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/individual-family"
            }
        }
    ],
    operations: [

    ],
    serverConfig: ()
};

# A service representing a network-accessible API
# bound to port `9090`.
@http:ServiceConfig {
    interceptors: [
        new r4:FHIRReadRequestInterceptor(apiConfig),
        new r4:FHIRCreateRequestInterceptor(apiConfig),
        new r4:FHIRSearchRequestInterceptor(apiConfig),
        new r4:FHIRRequestErrorInterceptor(),
        new r4:FHIRResponseInterceptor(apiConfig),
        new r4:FHIRResponseErrorInterceptor()
    ]
}
service /fhir/r4 on new http:Listener(9090) {

    // Search the resource type based on some filter criteria
    resource isolated function get Practitioner(http:RequestContext ctx, http:Request request) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : search");
        r4:FHIRContext fhirContext = check r4:getFHIRContext(ctx);
        log:printDebug(fhirContext.getRequestSearchParameters().toString());

        r4:Practitioner example = {
            id: "123",
            meta: {
                versionId: "abc123"
            },
            identifier: [
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US"
        };
        r4:BundleEntry[] entries = [];

        r4:BundleEntry entry = {
            fullUrl: request.rawPath,
            'resource: example
        };

        entries.push(entry);

        r4:Bundle bundle = {
            'type: r4:BUNDLE_TYPE_SEARCHSET,
            entry: entries
        };

        check setPractitionerSearchResponse(bundle, ctx);

        log:printDebug("[END]FHIR interaction : search");
        return;

    }
    // Read the current state of the resource
    resource isolated function get Practitioner/[string id](http:RequestContext ctx) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : read");
        io:println("FHIR interaction : read");

        r4:Practitioner example = {
            id: "123",
            meta: {
                versionId: "abc123"
            },
            identifier: [
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US"
        };
        check setPractitionerResponse(example, ctx);

        log:printDebug("[END]FHIR interaction : read");
        return;

    }
    // Create a new resource with a server assigned id
    resource isolated function post Practitioner(http:RequestContext ctx, http:Request request) returns json|r4:FHIRError {
        log:printDebug("FHIR interaction : create");
        io:println("[START] Create API Resource");

        r4:Practitioner fhirResource = check getPractitionerRequestResource(ctx);
        io:println("Request:" + fhirResource.toBalString());
        return {};

    }

}