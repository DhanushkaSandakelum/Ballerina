import wso2healthcare/healthcare.fhir.r4;

type inputRecord record {
    record {
        int id;
        string firstName;
        string secondName;
        string address;
        int age;
    } patient;
    record {
        string id;
        string description;
        string name;
    }[] treatments;
};

type outputRecord record {
    int id;
    string fullName;
    string age;
    record {
        string desc;
    }[] treatments;
};

function transform(inputRecord inputRecord) returns outputRecord => {
    id: inputRecord.patient.id,
    fullName: inputRecord.patient.firstName + " " + inputRecord.patient.secondName,
    age: inputRecord.patient.age.toBalString(),
    treatments: from var treatmentsItem in inputRecord.treatments
        select {
            desc: treatmentsItem.description
}
};
