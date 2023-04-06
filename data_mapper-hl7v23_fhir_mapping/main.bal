import ballerina/io;

//hl7v2tofhir package

public function main() returns error? {
    string queryMessageStr_ADT_A01 = "MSH|^~\\&|SendingApp|SendingFacility|HL7API|PKB|20160102101112||ADT^A01|ABC0000000001|P|2.3\r" +
        "PID|||9999999999^^^NHS^NH||Smith^John^Joe^^Mr||19700101|M|||Flat name^1, The Road^London^London^SW1A 1AA^GBR||01234567890^PRN~07123456789^PRS|^NET^john.smith@company.com~01234098765^WPN||||||||||||||||N|\r" +
        "PV1|1|I|^^^^^^^^My Ward||||^Jones^Stuart^James^^Dr^|^Smith^William^^^Dr^|^Foster^Terry^^^Mr^||||||||||V00001|||||||||||||||||||||||||201508011000|201508011200";

    string queryMessageStr_ADT_A04 = "MSH|^~\\&|SendingApp|SendingFacility|HL7API|PKB|20160102101112||ADT^A04|ABC0000000001|P|2.3\r" +
        "PID|||9999999999^^^NHS^NH||Smith^John^Joe^^Mr||19700101|M|||Flat name^1, The Road^London^London^SW1A 1AA^GBR||01234567890^PRN~07123456789^PRS|^NET^john.smith@company.com~01234098765^WPN||||||||||||||||N|\r" +
        "PV1|1|I|^^^^^^^^My Ward||||^Jones^Stuart^James^^Dr^|^Smith^William^^^Dr^|^Foster^Terry^^^Mr^||||||||||V00001|||||||||||||||||||||||||201508011000|201508011200";

    string queryMessageStr_ORU_O01 = "MSH|^~\\&|SendingApp|SendingFacility|ReceivingApp|ReceivingFacility|20230406103241||ORU^R01|MSG00001|P|2.3|||\r" +
        "PID|1||12345678^^^MRN||Doe^John^||20000101|M|||123 Main St^^Anytown^TX^12345^USA||(123)456-7890|||S||12345678|||000-00-0000||\r" +
        "PV1|1||OUTPATIENT||||||||||||||12345678|||||||||||||||||||||||||20220406103241|";

    io:println("Concept map -> Bundle ADT_A01 to Patient Map");
    V2ToFHIRParser(queryMessageStr_ADT_A01);

    io:println("Concept map -> Bundle ADT_A04 to Patient Map");
    V2ToFHIRParser(queryMessageStr_ADT_A04);

    io:println("Concept map -> Bundle ORU_R01 to Patient Map");
    V2ToFHIRParser(queryMessageStr_ORU_O01);

    // io:println("Concept map -> Bundle ADT_A01 to Patient Map");
    // return V2ToFHIRParser(queryMessageStr);

    // boolean test = CheckComputableANTLR("aa", ["a", "b"]);
    // io:println(test);
}

