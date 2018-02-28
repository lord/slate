## Medical Conditions - Create

```shell
curl -X POST {server_url}/api/v1/patients/{patient_id}/medical_conditions
-H "Content-type: application/json"
-H "Authorization: Bearer {jwt_token}"
-d '{
      "medical_condition": {
        "condition": "Throat Pain",
        "source": "Self Reported",
        "concept_id": "64",
        "snomed": "267102003",
        "icd10": "R07.0"
      }
    }'
```
```ruby
RestClient::Request.new(
  :method => :post,
  :url => "{server_url}/api/v1/patients/{patient_id}/medical_conditions",
  :headers => {
    "Content-type" => "application/json",
    "Authorization" => "Bearer {jwt_token}"
  },
  :payload => {
                 "medical_condition"=> {
                   "condition"=> "Throat Pain",
                   "source"=> "Self Reported",
                   "concept_id"=> "64",
                   "snomed"=> "267102003",
                   "icd10"=> "R07.0"
                 }
               }
).execute
```
> The above command returns JSON structured like this:

```json
{
  "patient_id": 111,
  "medical_condition": {
    "id": 123,
    "condition": "Throat Pain",
    "source": "Self Reported",
    "concept_id": "64",
    "snomed": "267102003",
    "icd10": "R07.0",
    "date_reported": "2017-11-13T15:47:40.000-05:00",
    "last_updated_date": "2017-11-13T15:47:40.000-05:00",
    "active": true
  }
}
```

To create a medical condition for a patient, make a request to:

### HTTP Request

`POST {server_url}/api/v1/patients/{patient_id}/medical_conditions`

This request must include a valid User JWT token, please see our [documentation](#user-tokens)

### Header Parameter

Parameter | Default
--------- | -------
Content-type | application/json
Authorization| Bearer {jwt_token}

The following parameters are required when creating a medical condition. To search for the condition and retrieve needed parameter values, reference [clinical concepts - search](#clinical-concepts-search).

### URL Parameter
 | Attribute | Required | Description
 -|--------- | ------- | -----------
 | patient_id | true| MDLIVE ID for patient

### Request Body Parameters

Attribute         | Required | Description
------------------|---------|-------------
medical_condition | true    | Parent attribute for condition
↳&nbsp;condition  | true    | Description of condition
↳&nbsp;source     | false   | 'Self Reported'
↳&nbsp;concept_id | false   | Concept ID returned in Clinical Concepts search
↳&nbsp;snomed     | false   | SNOMED returned in Clinical Concepts search
↳&nbsp;icd10      | false   | ICD-10 code returned in Clinical Concepts search
