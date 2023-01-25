# V2ToFHIR Package
This package intercept HL7 v2.3 messages and construct the relevant FHIR r4 resources.

# Components
Parser - Parse the HL7 v2.3 message to FHIR r4 resources
Transformations - Apply the relevant HL7 v2.3 message transformation to the required FHIR r4 resource type
Utils - Utility functions that are used in Transformations
Helpers - Helper functions to the Utils functions
Antlr - Computable ANTLR that are used in Utils