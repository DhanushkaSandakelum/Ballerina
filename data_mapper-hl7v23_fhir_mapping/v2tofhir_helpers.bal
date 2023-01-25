import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

public function HL7v2ToFHIRr4Helper_GetHumanNameUse(hl7v23:ID id) returns r4:HumanNameUse {
    match id {
        "usual" => {
            return "usual";
        }
        "official" => {
            return "official";
        }
        "temp" => {
            return "temp";
        }
        "nickname" => {
            return "nickname";
        }
        "anonymous" => {
            return "anonymous";
        }
        "old" => {
            return "old";
        }
        "maiden" => {
            return "maiden";
        }
        _ => {
            return "usual";
        }
    }
}

public function HL7v2ToFHIRr4Helper_GetAddressType(hl7v23:ID id) returns r4:AddressType {
    match id {
        "postal" => {
            return "postal";
        }
        "physical" => {
            return "physical";
        }
        "both" => {
            return "both";
        }
        _ => {
            return "postal";
        }
    }
}

public function HL7v2ToFHIRr4Helper_GetAddressUse(hl7v23:ID id) returns r4:AddressUse {
    match id {
        "home" => {
            return "home";
        }
        "work" => {
            return "work";
        }
        "temp" => {
            return "temp";
        }
        "old" => {
            return "old";
        }
        "billing" => {
            return "billing";
        }
        _ => {
            return "home";
        }
    }
}