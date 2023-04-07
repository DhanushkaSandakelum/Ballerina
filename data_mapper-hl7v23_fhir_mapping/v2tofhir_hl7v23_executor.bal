import ballerina/io;

public function HL7V23_Executor(string queryStr_hl7v23_adt_a01, string queryStr_hl7v23_adt_a04, string queryStr_hl7v23_oru_r01) {
    io:println("Concept map -> Bundle ADT_A01 to Patient Map");
    HL7V23_V2ToFHIRParser(queryStr_hl7v23_adt_a01);

    io:println("Concept map -> Bundle ADT_A04 to Patient Map");
    HL7V23_V2ToFHIRParser(queryStr_hl7v23_adt_a04);

    io:println("Concept map -> Bundle ORU_R01 to Patient Map");
    HL7V23_V2ToFHIRParser(queryStr_hl7v23_oru_r01);
}
