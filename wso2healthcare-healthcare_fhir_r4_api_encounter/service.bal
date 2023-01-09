import wso2healthcare/healthcare.fhir.r4;
import ballerina/io;
import ballerina/log;
import ballerina/http;

final r4:ResourceAPIConfig apiConfig = {
    resourceType: "Encounter",
    profiles: [
        "http://hl7.org/fhir/StructureDefinition/Encounter"
    ],
    defaultProfile: (),
    searchParameters: [
        {
            name: "reason-reference",
            active: true,
            information: {
                description: "Reason the encounter takes place (reference)",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-reason-reference"
            }
        },
        {
            name: "part-of",
            active: true,
            information: {
                description: "Another Encounter this encounter is part of",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-part-of"
            }
        },
        {
            name: "participant-type",
            active: true,
            information: {
                description: "Role of participant in encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-participant-type"
            }
        },
        {
            name: "class",
            active: true,
            information: {
                description: "Classification of patient encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-class"
            }
        },
        {
            name: "identifier",
            active: true,
            information: {
                description: "[Encounter](encounter.html): Identifier(s) by which this encounter is known",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/clinical-identifier"
            }
        },
        {
            name: "location-period",
            active: true,
            information: {
                description: "Time period during which the patient was present at the location",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-location-period"
            }
        },
        {
            name: "episode-of-care",
            active: true,
            information: {
                description: "Episode(s) of care that this encounter should be recorded against",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-episode-of-care"
            }
        },
        {
            name: "date",
            active: true,
            information: {
                description: "[Encounter](encounter.html): A date within the period the Encounter lasted",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/clinical-date"
            }
        },
        {
            name: "patient",
            active: true,
            information: {
                description: "[Encounter](encounter.html): The patient or group present at the encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/clinical-patient"
            }
        },
        {
            name: "location",
            active: true,
            information: {
                description: "Location the encounter takes place",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-location"
            }
        },
        {
            name: "account",
            active: true,
            information: {
                description: "The set of accounts that may be used for billing for this Encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-account"
            }
        },
        {
            name: "type",
            active: true,
            information: {
                description: "[Encounter](encounter.html): Specific type of encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/clinical-type"
            }
        },
        {
            name: "status",
            active: true,
            information: {
                description: "planned | arrived | triaged | in-progress | onleave | finished | cancelled +",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-status"
            }
        },
        {
            name: "subject",
            active: true,
            information: {
                description: "The patient or group present at the encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-subject"
            }
        },
        {
            name: "appointment",
            active: true,
            information: {
                description: "The appointment that scheduled this encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-appointment"
            }
        },
        {
            name: "special-arrangement",
            active: true,
            information: {
                description: "Wheelchair, translator, stretcher, etc.",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-special-arrangement"
            }
        },
        {
            name: "service-provider",
            active: true,
            information: {
                description: "The organization (facility) responsible for this encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-service-provider"
            }
        },
        {
            name: "length",
            active: true,
            information: {
                description: "Length of encounter in days",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-length"
            }
        },
        {
            name: "based-on",
            active: true,
            information: {
                description: "The ServiceRequest that initiated this encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-based-on"
            }
        },
        {
            name: "reason-code",
            active: true,
            information: {
                description: "Coded reason the encounter takes place",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-reason-code"
            }
        },
        {
            name: "participant",
            active: true,
            information: {
                description: "Persons involved in the encounter other than the patient",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-participant"
            }
        },
        {
            name: "diagnosis",
            active: true,
            information: {
                description: "The diagnosis or procedure relevant to the encounter",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-diagnosis"
            }
        },
        {
            name: "practitioner",
            active: true,
            information: {
                description: "Persons involved in the encounter other than the patient",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Encounter-practitioner"
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
    resource isolated function get Encounter(http:RequestContext ctx, http:Request request) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : search");
        r4:FHIRContext fhirContext = check r4:getFHIRContext(ctx);
        log:printDebug(fhirContext.getRequestSearchParameters().toString());

        r4:Encounter example = {
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

        check setEncounterSearchResponse(bundle, ctx);

        log:printDebug("[END]FHIR interaction : search");
        return;

    }
    // Read the current state of the resource
    resource isolated function get Encounter/[string id](http:RequestContext ctx) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : read");
        io:println("FHIR interaction : read");

        r4:Encounter example = {
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
        check setEncounterResponse(example, ctx);

        log:printDebug("[END]FHIR interaction : read");
        return;

    }
    // Create a new resource with a server assigned id
    resource isolated function post Encounter(http:RequestContext ctx, http:Request request) returns json|r4:FHIRError {
        log:printDebug("FHIR interaction : create");
        io:println("[START] Create API Resource");

        r4:Encounter fhirResource = check getEncounterRequestResource(ctx);
        io:println("Request:" + fhirResource.toBalString());
        return {};

    }

}
