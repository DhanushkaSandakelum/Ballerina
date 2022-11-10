import ballerina/io;

public class Person {
    // @desc - Member variables
    private string name;
    private int age;

    // @desc - init method defines the default constructor
    public function init(string n = "John", int a = 10) {
        self.name = n;
        self.age = a;
    }

    // @desc - Getters
    public function getName() returns string {return self.name;}
    public function getAge() returns int {return self.age;}

    // @desc - Setters
    public function setName(string n) {self.name = n;}
    public function setAge(int a) {self.age = a;}
}

public function main() {
    // @desc - Can user new Person() as well
    Person person1 = new ("Dhanushka", 22);

    // @desc - Get data from the person1 object
    io:println(`Name: ${person1.getName()} Age: ${person1.getAge()}`);

    // @desc - Set data to the person1 object
    person1.setName("Janindu");
    person1.setAge(12);
    io:println(`Name: ${person1.getName()} Age: ${person1.getAge()}`);
}
