import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7;
import ballerina/log;

// Parsing hl7 message
function parseQueryMessage() returns hl7:HL7Error? {
    string queryMessageStr = "MSH|^~\\&|ADT1|MCM|LABADT|MCM||SECURITY|QRY^A19|MSG00001|P|2.3|||||||\r"
                            + "QRD|20220828104856+0000|R|I|QueryID01|||5.0|1^ADAM^EVERMAN^^|VXI|SIIS|";
    // Wrap the above sample HL7 message with essential HL7 message Start Block character (1 byte)ASCII , i.e., <0x0B> 
    // and End Block character (1 byte)ASCII , i.e., <0x1C>
    byte[] queryMessage = hl7:createHL7WirePayload(queryMessageStr.toBytes());

    // log:printInfo(queryMessage.toBalString());
    hl7:HL7Parser parser = new ();
    hl7:Message|hl7:GenericMessage parsedMsg = check parser.parse(queryMessage);

    log:printInfo(parsedMsg.toBalString());
    if parsedMsg is hl7v23:QRY_A19 {
        log:printInfo("Query ID : " + parsedMsg.qrd.qrd4);
    }
}

// Encoding hl7 message model to wire format
function encodeQueryMessage() returns error? {
    hl7v23:QRY_A19 qry_a19 = {
        msh: {
            msh3: {hd1: "ADT1"},
            msh4: {hd1: "MCM"},
            msh5: {hd1: "LABADT"},
            msh6: {hd1: "MCM"},
            msh8: "SECURITY",
            msh9: {cm_msg1: "QRY", cm_msg2: "A19"},
            msh10: "MSG00001",
            msh11: {pt1: "P"},
            msh12: "2.3"
        },
        qrd: {
            qrd1: {ts1: "20220828104856+0000"},
            qrd2: "R",
            qrd3: "I",
            qrd4: "QueryID01",
            qrd7: {cq1: 5},
            qrd8: [{xcn1: "1", xcn2: "ADAM", xcn3: "EVERMAN"}],
            qrd9: [{ce1: "VXI"}],
            qrd10: [{ce1: "SIIS"}]
        }
    };

    hl7:HL7Encoder encoder = new ();
    byte[] encodedQRYA19 = check encoder.encode(hl7v23:VERSION, qry_a19);
    log:printInfo("String: " + check string:fromBytes(encodedQRYA19));
    log:printInfo("Base16: " + encodedQRYA19.toBase16());
}

// Generic hl7 client
function sendHl7Message(byte[] encodedQRYA19) returns hl7:HL7Error|error? {
    // Send to HL7 server
    hl7:HL7Client hl7client = check new("localhost", 56919);
    byte[] responseMsg = check hl7client.sendMessage(encodedQRYA19);
    log:printInfo("Response : " + check string:fromBytes(responseMsg));
}

public function main() returns error? {
    // return parseQueryMessage();
    
    // return encodeQueryMessage();

    hl7v23:QRY_A19 qry_a19 = {
        msh: {
            msh3: {hd1: "ADT1"},
            msh4: {hd1: "MCM"},
            msh5: {hd1: "LABADT"},
            msh6: {hd1: "MCM"},
            msh8: "SECURITY",
            msh9: {cm_msg1: "QRY", cm_msg2: "A19"},
            msh10: "MSG00001",
            msh11: {pt1: "P"},
            msh12: "2.3"
        },
        qrd: {
            qrd1: {ts1: "20220828104856+0000"},
            qrd2: "R",
            qrd3: "I",
            qrd4: "QueryID01",
            qrd7: {cq1: 5},
            qrd8: [{xcn1: "1", xcn2: "ADAM", xcn3: "EVERMAN"}],
            qrd9: [{ce1: "VXI"}],
            qrd10: [{ce1: "SIIS"}]
        }
    };

    hl7:HL7Encoder encoder = new ();
    byte[] encodedQRYA19 = check encoder.encode(hl7v23:VERSION, qry_a19);

    return sendHl7Message(encodedQRYA19);
}
