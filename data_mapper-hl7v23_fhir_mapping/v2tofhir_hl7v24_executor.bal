import ballerina/io;

public function HL7V24_Executor(string queryStr_hl7v24_adt_a01, string queryStr_hl7v24_adt_a04, string queryStr_hl7v24_oru_r01) {
    io:println("Concept map -> Bundle ADT_A01 to Patient Map");
    HL7V24_V2ToFHIRParser(queryStr_hl7v24_adt_a01);

    io:println("Concept map -> Bundle ADT_A04 to Patient Map");
    HL7V24_V2ToFHIRParser(queryStr_hl7v24_adt_a04);

    io:println("Concept map -> Bundle ORU_R01 to Patient Map");
    HL7V24_V2ToFHIRParser(queryStr_hl7v24_oru_r01);
}
