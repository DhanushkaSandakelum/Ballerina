import ballerina/io;

//hl7v2tofhir package



public function main() returns error? {
    string queryMessageStr = "MSH|^~\\&|SendingApp|SendingFacility|HL7API|PKB|20160102101112||ADT^A01|ABC0000000001|P|2.3\r" +
"PID|||9999999999^^^NHS^NH||Smith^John^Joe^^Mr||19700101|M|||Flat name^1, The Road^London^London^SW1A 1AA^GBR||01234567890^PRN~07123456789^PRS|^NET^john.smith@company.com~01234098765^WPN||||||||||||||||N|\r" +
"PV1|1|I|^^^^^^^^My Ward||||^Jones^Stuart^James^^Dr^|^Smith^William^^^Dr^|^Foster^Terry^^^Mr^||||||||||V00001|||||||||||||||||||||||||201508011000|201508011200";

    io:println("Concept map -> Bundle ADT_A01 to Patient Map");

    return V2ToFHIRParser(queryMessageStr);

    // boolean test = CheckComputableANTLR("aa", ["a", "b"]);

    // io:println(test);
}

