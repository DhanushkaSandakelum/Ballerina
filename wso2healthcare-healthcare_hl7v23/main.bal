import ballerina/log;
import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7;
import ballerina/uuid;
import ballerina/tcp;

service on new tcp:Listener(3000) {
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        log:printInfo("Client connected to echoServer: " + caller.remotePort.toString());
        return new HL7ServiceConnectionService();
    }

}

service class HL7ServiceConnectionService {
    *tcp:ConnectionService;

    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns tcp:Error? {
        string|error fromBytes = string:fromBytes(data);
        if fromBytes is string {
            log:printInfo("Received HL7 Message: " + fromBytes);
        }

        hl7:HL7Parser parser = new ();
        hl7:Message|hl7:GenericMessage|hl7:HL7Error parsedMsg = parser.parse(data);
        if parsedMsg is hl7:HL7Error {
            return error("Error occurred while parsing the received message", parsedMsg);
        }
        log:printInfo("Parsed HL7 message:" + parsedMsg.toString());

        // Extract Message header (MSH)
        hl7v23:MSH? msh = ();
        if parsedMsg is hl7:Message && parsedMsg.hasKey("msh") {
            anydata mshEntry = parsedMsg["msh"];
            hl7v23:MSH|error tempMSH = mshEntry.ensureType();
            if tempMSH is error {
                return error("Error occurred while casting MSH");
            }
            msh = tempMSH;
        }
        if msh is () {
            return error("Failed to extract MSH from HL7 message");
        }

        // Create Ackknowledgement message
        hl7v23:ACK ack = {
            msh: {
                msh3: {hd1: "TESTSERVER"},
                msh4: {hd1: "WSO2OH"},
                msh5: {hd1: msh.msh3.hd1},
                msh6: {hd1: msh.msh4.hd1},
                msh9: {cm_msg1: hl7v23:ACK_MESSAGE_TYPE},
                msh10: uuid:createType1AsString().substring(0, 8),
                msh11: {pt1: "P"},
                msh12: "2.3"
            },
            msa: {
                msa1: "AA",
                msa2: msh.msh10
            }
        };
        // encode message to wire format
        hl7:HL7Encoder encoder = new ();
        byte[]|hl7:HL7Error encodedMsg = encoder.encode(hl7v23:VERSION, ack);
        if encodedMsg is hl7:HL7Error {
            return error("Error occurred while encoding acknowledgement");
        }

        string|error resp = string:fromBytes(encodedMsg);
        if resp is string {
            log:printInfo("Encoded HL7 ACK Response Message: " + resp);
        }

        // Echoes back the data to the client from which the data is received.
        check caller->writeBytes(encodedMsg);
    }

    remote function onError(tcp:Error err) {
        log:printError("An error occurred", 'error = err);
    }

    remote function onClose() {
        log:printInfo("Client left");
    }
}
