// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is auto-generated by Ballerina for managing utility functions.
// It should not be modified by hand.

import wso2healthcare/healthcare.fhir.r4;
import ballerina/lang.value;
import ballerina/http;

isolated function setEncounterSearchResponse(r4:Bundle resourceBundle, http:RequestContext httpContext) returns r4:FHIRError? {
    r4:FHIRContainerResourceEntity entity = new (resourceBundle);
    check r4:setResponseResourceEntity(entity, httpContext);
}

isolated function setEncounterResponse(r4:Encounter fhirResource, http:RequestContext httpContext) returns r4:FHIRError? {
    r4:FHIRResourceEntity entity = new (fhirResource);
    check r4:setResponseResourceEntity(entity, httpContext);
}

isolated function getEncounterRequestResource(http:RequestContext httpContext) returns r4:Encounter|r4:FHIRError {
    r4:FHIRResourceEntity patientPayload = check r4:getRequestResourceEntity(httpContext);
    value:Cloneable resourceRecord = patientPayload.unwrap();

    if resourceRecord is r4:Encounter {
        return resourceRecord;
    } else {
        string diagMsg = "Expected r4:Encounter FHIR resource model not found. Instead, found a model of type:" + (typeof resourceRecord).toBalString();
        return r4:createInternalFHIRError("Incoming r4:Encounter resource model not found", r4:ERROR, r4:PROCESSING_NOT_FOUND, diagnostic = diagMsg);
    }
}
