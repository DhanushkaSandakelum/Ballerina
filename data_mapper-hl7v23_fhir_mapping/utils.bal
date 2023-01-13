import wso2healthcare/healthcare.fhir.r4;

# Get FHIR r4 gender (male, femail, other, unknown)
#
# + pid8 - Sex (in hl7:PID)
# + return - [male | female | other | unknown] AdministrativeGender (in r4:AdministrativeGender)
public function getFHIR_r4_gender(string pid8) returns r4:AdministrativeGender {
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

public function getFHIR_r4_multipleBirthBoolean(string pid24) returns boolean {
    match pid24 {
        "N" => {
            return false;
        }
        "Y" => {
            return true;
        }
    }
}