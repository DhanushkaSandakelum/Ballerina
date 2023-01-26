import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

public function HL7v2ToFHIRr4Helper_GetHumanNameUse(hl7v23:ID id) returns r4:HumanNameUse => id is r4:HumanNameUse ? id: "usual";

public function HL7v2ToFHIRr4Helper_GetAddressType(hl7v23:ID id) returns r4:AddressType => id is r4:AddressType ? id: "postal";

public function HL7v2ToFHIRr4Helper_GetAddressUse(hl7v23:ID id) returns r4:AddressUse => id is r4:AddressUse ? id: "home";

public function HL7v2ToFHIRr4Helper_GetContactPointUse(hl7v23:ID id) returns r4:ContactPointUse => id is r4:ContactPointUse ? id: "home";

public function HL7v2ToFHIRr4Helper_GetContactPointSystem(hl7v23:ID id) returns r4:ContactPointSystem => id is r4:ContactPointSystem ? id: "phone";