import wso2healthcare/healthcare.fhir.r4;
import ballerina/io;
import ballerina/log;
import ballerina/http;

final r4:ResourceAPIConfig apiConfig = {
    resourceType: "Organization",
    profiles: [
        "http://hl7.org/fhir/StructureDefinition/Organization"
    ],
    defaultProfile: (),
    searchParameters: [
        {
            name: "address-state",
            active: true,
            information: {
                description: "A state specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address-state"
            }
        },
        {
            name: "address-use",
            active: true,
            information: {
                description: "A use code specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address-use"
            }
        },
        {
            name: "endpoint",
            active: true,
            information: {
                description: "Technical endpoints providing access to services operated for the organization",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-endpoint"
            }
        },
        {
            name: "type",
            active: true,
            information: {
                description: "A code for the type of organization",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-type"
            }
        },
        {
            name: "active",
            active: true,
            information: {
                description: "Is the Organization record active",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-active"
            }
        },
        {
            name: "identifier",
            active: true,
            information: {
                description: "Any identifier for the organization (not the accreditation issuer's identifier)",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-identifier"
            }
        },
        {
            name: "address-country",
            active: true,
            information: {
                description: "A country specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address-country"
            }
        },
        {
            name: "address-postalcode",
            active: true,
            information: {
                description: "A postal code specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address-postalcode"
            }
        },
        {
            name: "address",
            active: true,
            information: {
                description: "A server defined search that may match any of the string fields in the Address, including line, city, district, state, country, postalCode, and/or text",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address"
            }
        },
        {
            name: "address-city",
            active: true,
            information: {
                description: "A city specified in an address",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-address-city"
            }
        },
        {
            name: "name",
            active: true,
            information: {
                description: "A portion of the organization's name or alias",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-name"
            }
        },
        {
            name: "partof",
            active: true,
            information: {
                description: "An organization of which this organization forms a part",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-partof"
            }
        },
        {
            name: "phonetic",
            active: true,
            information: {
                description: "A portion of the organization's name using some kind of phonetic matching algorithm",
                builtin: false,
                documentation: "http://hl7.org/fhir/SearchParameter/Organization-phonetic"
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
    resource isolated function get Organization(http:RequestContext ctx, http:Request request) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : search");
        r4:FHIRContext fhirContext = check r4:getFHIRContext(ctx);
        log:printDebug(fhirContext.getRequestSearchParameters().toString());

        r4:Organization example = {
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

        check setOrganizationSearchResponse(bundle, ctx);

        log:printDebug("[END]FHIR interaction : search");
        return;

    }
    // Read the current state of the resource
    resource isolated function get Organization/[string id](http:RequestContext ctx) returns json|xml|r4:FHIRError {
        log:printDebug("FHIR interaction : read");
        io:println("FHIR interaction : read");

        r4:Organization example = {
            id: "123",
            meta: {
                versionId: "abc123"
            },
            identifier: [
            ],
            implicitRules: "https://www.hl7.org/fhir",
            language: "en-US"
        };
        check setOrganizationResponse(example, ctx);

        log:printDebug("[END]FHIR interaction : read");
        return;

    }
    // Create a new resource with a server assigned id
    resource isolated function post Organization(http:RequestContext ctx, http:Request request) returns json|r4:FHIRError {
        log:printDebug("FHIR interaction : create");
        io:println("[START] Create API Resource");

        r4:Organization fhirResource = check getOrganizationRequestResource(ctx);
        io:println("Request:" + fhirResource.toBalString());
        return {};

    }

}
