

# Patient Template

## Template Overview

This template provides a boilerplate code for rapid implementation of FHIR APIs and creating, accessing and manipulating FHIR resources.


| Module/Element       | Version |
|---| --- |
| Ballerina Language   | Swan Lake 2201.1.2 |
| FHIR version         | r4 |
| Implementation Guide | [http://hl7.org/fhir/](http://hl7.org/fhir/) |
| Profile URL          | [http://hl7.org/fhir/StructureDefinition/Patient](http://hl7.org/fhir/StructureDefinition/Patient) |
| Documentation        | [https://www.hl7.org/fhir/Patient\.html](https://www.hl7.org/fhir/Patient\.html) |

### Dependency List

| Module | Version |
| --- | --- |
| wso2healthcare/healthcare.fhir.r4 | 0.1.1 |
| wso2healthcare/healthcare.base    | 0.1.0 |
|

This template includes,

- Ballerina service for 'FHIR Resource Name' FHIR resource with following FHIR interactions.
- Search
- Read
- Create
- Generated Utility functions to handle context data
- Pre-engaged FHIR pre-processors and post-processors for built-in FHIR Server capabilities

## Usage
This section focuses on how to use this template to implement, configure and deploy FHIR Resource API of a FHIR server:

### Prerequisites

1. Install [Ballerina](https://ballerina.io/learn/install-ballerina/set-up-ballerina/) 2201.1.2 (Swan Lake Update 1) or later

### Setup and run in VM or Developer Machine

1) Create an API project from this template

    ```bal new -t wso2healthcare/healthcare.fhir.r4.api.patient PatientAPI```
2) Perform necessary source system connections and data element mapping in `service.bal`.

3) Run by executing command: `bal run` in your terminal to run this package.

4) Invoke `<BASE_URL>/fhir/r4/Patient`
    1) Invoke from localhost : `http://localhost:9090/fhir/r4/Patient`

### Setup and deploy on [Choreo](https://wso2.com/choreo/)
1) Create an API project from this template

    ```bal new -t wso2healthcare/healthcare.fhir.r4.api.patient PatientAPI```
2) Perform necessary source system connections and data element mapping in `service.bal`.

3) Create GitHub repository and push created source to relevant branch

4) Follow instructions to [connect project repository to Choreo](https://wso2.com/choreo/docs/tutorials/connect-your-existing-ballerina-project-to-choreo/)

5) Deploy API by following [instructions to deploy](https://wso2.com/choreo/docs/tutorials/create-your-first-rest-api/#step-2-deploy)
and [test](https://wso2.com/choreo/docs/tutorials/create-your-first-rest-api/#step-2-deploy)

6) Invoke `<BASE_URL>/fhir/r4/Patient`

    `https://<HOSTNAME>/<TENANT_CONTEXT>/fhir/r4/Patient`
