import ballerina/io;

type inputRecord record {|
|};

type outputRecord record {|
|};

function transformerApplierGetInput() returns inputRecord|error {
    json|io:Error readInput = io:fileReadJson("./src/fhirResources/response/patient.res.fhir.json");

    if readInput is io:Error {
        return error("read failed");
    }

    inputRecord input = <inputRecord>readInput.cloneReadOnly();

    return input;
}

function transformerApplierGetOutput() returns outputRecord|error {

    json|io:Error readOutput = io:fileReadJson("./src/fhirResources/request/person.req.fhir.json");

    if readOutput is io:Error {
        return error("read failed");
    }

    outputRecord output = <outputRecord>readOutput.cloneReadOnly();

    return output;
}

function FHIRTransformer(inputRecord inputRecord = check transformerApplierGetInput()) returns outputRecord => {};
