public type PersonDetails record {
    record {
        int id;
        string firstName;
        string lastName;
        int age;
    } person;
    record {
        string id;
        string name;
        int credits;
    }[] course;
};

type StudentDetails record {
    int id;
    string fullName;
    string age;
    record {
        string title;
        int credits;
    }[] courses;
    int totalCredits;
};

function transform(PersonDetails personDetails) returns StudentDetails => {
    id: personDetails.person.id,
    age: personDetails.person.age.toBalString(),
    fullName: personDetails.person.firstName + " " + personDetails.person.lastName,
    courses: from var courseItem in personDetails.course
        select {
            title: courseItem.name,
            credits: courseItem.credits
},
    totalCredits: personDetails.course.reduce(function(int total, record{string id; string name; int credits;} course)  returns int {return total + course.credits;}, 0)
};
