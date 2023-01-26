import ballerina/test;

@test:Config {}
function CheckComputableANTLRTest() {
    test:assertEquals(CheckComputableANTLR([{identifier: "a", comparisonOperator: "IN", valueList: ["a", "b"]}]), true);
    test:assertEquals(CheckComputableANTLR([{identifier: "a", comparisonOperator: "IN", valueList: ["b", "c"]}]), false);
    test:assertEquals(CheckComputableANTLR([{identifier: "a", comparisonOperator: "IN", valueList: ["b", "a"]}, {identifier: "a", comparisonOperator: "IN", valueList: ["b", "a"]}]), true);
}
