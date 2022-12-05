public type AccountDetails record {
    string resourceType;
    string id;
    record {
        string status;
        string div;
    } text;
    record {
        string system;
        string value;
    }[] identifier;
    string status;
    record {
        record {
            string system;
            string code;
            string display;
        }[] coding;
        string text;
    } 'type;
    string name;
    record {
        string reference;
        string display;
    }[] subject;
    record {
        string 'start;
        string end;
    } servicePeriod;
    record {
        record {
            string reference;
        } coverage;
        int priority;
    }[] coverage;
    record {
        string reference;
    } owner;
    string description;
    record {
        record {
            string system;
            string code;
            string display;
        }[] tag;
    } meta;
};

type AbstractDetails record {
    string name;
    record {
        string display;
    }[] subject;
    record {
        string 'start;
        string end;
    } servicePeriod;
};

function fhirTransform(AccountDetails accountDetails) returns AbstractDetails => {
    name: accountDetails.name,
    servicePeriod: accountDetails.servicePeriod,
    subject: from var subjectItem in accountDetails.subject
        select {
            display: subjectItem.display
}
};
