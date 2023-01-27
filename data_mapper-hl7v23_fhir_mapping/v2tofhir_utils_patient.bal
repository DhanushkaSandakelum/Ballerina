import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v23;

# Get FHIR r4 gender (male, female, other, unknown)
#
# + pid8 - Sex (in hl7:PID)
# + return - gender (in r4:Patient)
public function GetHL7_PID_AdministrativeSex(string pid8) returns r4:AdministrativeGender {
    match pid8 {
        "F" => {
            return "male";
        }
        "M" => {
            return "female";
        }
        "O" => {
            return "other";
        }
        "U" => {
            return "unknown";
        }
        _ => {
            return "unknown";
        }
    }
}

# Get FHIR r4 name
#
# + pid5 - Patient Name (in hl7:PID)
# + pid9 - Patient Alias (in hl7:PID)
# + return - name (in r4:Patient)
public function GetHL7_PID_PatientName(hl7v23:XPN[] pid5, hl7v23:XPN[] pid9) returns r4:HumanName[] {
    r4:HumanName[] humanNames = [];

    foreach hl7v23:XPN item in pid5 {

        humanNames.push({
            // id: 
            // extension:
            use: HL7v2ToFHIRr4Helper_GetHumanNameUse(item.xpn7),
            // text:
            family: item.xpn1,
            given: [item.xpn2, item.xpn3],
            prefix: [item.xpn5],
            suffix: [item.xpn4, item.xpn6]
            // period:
        });
    }

    foreach hl7v23:XPN item in pid9 {
        humanNames.push({
            // id: 
            // extension:
            use: HL7v2ToFHIRr4Helper_GetHumanNameUse(item.xpn7),
            // text:
            family: item.xpn1,
            given: [item.xpn2, item.xpn3],
            prefix: [item.xpn5],
            suffix: [item.xpn4, item.xpn6]
            // period:
        });
    }

    return humanNames;
}

# Get FHIR r4 Address
#
# + pid12 - County Code (in hl7:PID)
# + pid11 - Patient address (in hl7:PID)
# + return - address (in r4:Patient)
public function GetHL7_PID_Address(string pid12, hl7v23:XAD[] pid11) returns r4:Address[] {
    r4:Address[] address = [{district: pid12}];

    foreach hl7v23:XAD item in pid11 {
        address.push({
            // id: 
            // extension: [item.xad10],
            use: CheckComputableANTLR([{identifier: item.xad7, comparisonOperator: "IN", valueList: ["BA", "BI", "C", "B", "H", "O"]}]) ? HL7v2ToFHIRr4Helper_GetAddressUse(item.xad7) : (),
            'type: CheckComputableANTLR([{identifier: item.xad7, comparisonOperator: "IN", valueList: ["M", "SH"]}]) ? HL7v2ToFHIRr4Helper_GetAddressType(item.xad7) : (),
            // text:
            line: [item.xad1, item.xad2],
            city: item.xad3,
            district: item.xad9,
            state: item.xad4,
            postalCode: item.xad5,
            country: item.xad6
            // period:
        });
    }

    return address;
}

# Get FHIR r4 telecom
#
# + pid13 - Phone Number - Home (in hl7:PID)
# + pid14 - Phone Number - Business (in hl7:PID)
# + return - telecom (in r4:Patient)
public function GetHL7_PID_PhoneNumber(hl7v23:XTN[] pid13, hl7v23:XTN[] pid14) returns r4:ContactPoint[] {
    r4:ContactPoint[] phoneNumbers = [];

    //get ContactPointFromXTN use this
    foreach hl7v23:XTN item in pid13 {
        phoneNumbers.push({
            // id: 
            // extension:
            system: HL7v2ToFHIRr4Helper_GetContactPointSystem(item.xtn3),
            value: CheckComputableANTLR([
                    {identifier: item.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]},
                    {identifier: item.xtn7.toString(), comparisonOperator: "IN", valueList: []}
                                        //, {identifier: item.xtn12, comparisonOperator: "IN", valueList: []}                    //TODO: xtn12 is not defined yet
                ]) ? item.xtn1 :
                    (CheckComputableANTLR([{identifier: item.xtn3, comparisonOperator: "NIN", valueList: ["Internet", "X.400"]}])) ? (item.xtn4) : (),
            use: HL7v2ToFHIRr4Helper_GetContactPointUse(item.xtn2)
            // rank:
            // period:
        });
    }

    foreach hl7v23:XTN item in pid14 {
        phoneNumbers.push({
            // id: 
            // extension:
            system: HL7v2ToFHIRr4Helper_GetContactPointSystem(item.xtn3),
            value: item.xtn1 + item.xtn4,
            use: HL7v2ToFHIRr4Helper_GetContactPointUse(item.xtn2)
            // rank:
            // period:
        });
    }

    return phoneNumbers;
}

# Get FHIR r4 communication
#
# + pid15 - Primary Language (in hl7:PID)
# + return - communication (in r4:Patient)
public function GetHL7_PID_PrimaryLanguage(hl7v23:CE pid15) returns r4:CommunicationBackboneElement[] {
    r4:CodeableConcept language = {
        id: pid15.ce1,
        // extension:
        // coding: 
        text: pid15.ce2
    };

    r4:CommunicationBackboneElement[] languages = [
        {
            language: language
        }
    ];

    return languages;
}

# Get FHIR r4 maritalStatus
#
# + pid16 - Marital Status (in hl7:PID) 
# + return - maritalStatus (in r4:Patient)
public function GetHL7_PID_MaritalStatus(string pid16) returns r4:Coding[] {
    r4:Coding[] maritialStatues = [{code: pid16}];

    return maritialStatues;
}

// public function GetHL7_PID_Religion(string pid17) returns r4:Extension[]{
//     r4:Extension[] extensions = [{url: pid16}];

//     return  extensions;
// }

# Get FHIR r4 identifier
#
# + pid19 - SSN Number - Patient (in hl7:PID)
# + return - identifier (in r4:Patient)
public function GetHL7_PID_SSNNumberPatient(string pid19) returns r4:Identifier[] {
    r4:Identifier[] identifier = [{value: pid19}];

    return identifier;
}

# Get FHIR r4 extension
#
# + pid23 - Birth Place (in hl7:PID)
# + return - extension (in r4:Patient)
public function GetHL7_PID_BirthPlace(string pid23) returns r4:Extension[] {
    r4:StringExtension[] extension = [{url: pid23, valueString: pid23}];

    return extension;
}

# Get FHIR r4 multipleBirthBoolean
#
# + pid24 - Multiple Birth Indicator (in hl7:PID)
# + return - multipleBirthBoolean (in r4:Patient)
public function GetHL7_PID_MultipleBirthIndicator(string pid24) returns boolean {
    match pid24 {
        "N" => {
            return false;
        }
        "Y" => {
            return true;
        }
        _ => {
            return false;
        }
    }
}

# Get FHIR r4 multipleBirthInteger
#
# + pid25 - Birth Order (in hl7:PID)
# + return - multipleBirthInteger (in r4:Patient)
public function GetHL7_PID_BirthOrder(float pid25) returns int {
    return <int>pid25;
}

# Get FHIR r4 deceasedBoolean
#
# + pid30 - Patient Death Indicator (in hl7:PID)
# + return - deceasedBoolean (in r4:Patient)
public function GetHL7_PID_PatientDeathIndicator(string pid30) returns boolean {
    match pid30 {
        "false" => {
            return false;
        }
        "true" => {
            return true;
        }
        _ => {
            return false;
        }
    }
}
