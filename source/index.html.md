---
title: API Reference

language_tabs:
  - shell
  - php

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Introduction

Welcome to the DNA API! You can use our API to access DNA API endpoints, which can get information on various elements customers, devices, and billing in our database.

We have language bindings in Shell and PHP we also have <a href='https://www.getpostman.com/collections/af70b4327c9f4ded36f5'>Postman</a> for you to test the methods without writing code! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.


This example API documentation page was created with [Slate](https://github.com/tripit/slate). 

# API Flow

The Api offers different methods here are some flow examples so you can visualize how the information will flow:

## Flow Diagram Legend

<img src="images/legend.png" alt="Legend">

## Create Client Method

<img src="images/client.png" alt="Client">

## Activate Client Method

<img src="images/activate.png" alt="Activate">

## Suspend Client Method

<img src="images/suspend.png" alt="Suspend">

## Create Device Method

<img src="images/device.png" alt="Device">

# Authentication

> To authorize, use this code:

```shell
# With shell, you can just pass the correct header with each request
curl "https://staging.api.nexogy.com/api/oauth/token?grant_type=password&client_id=<value>&client_secret=<value>&username=<value>&password=<value>&scope=<value>"
  -H "Accept: application/json"
```

```php

```

> Make sure to replace the required `<value>` with the information provided.

> The above command returns a JSON structured like this:

```json
[
  {  
     "token_type":"Bearer",
     "expires_in":1200,
     "access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2",
     "refresh_token":"kvwLi6kTeq7DGbfsKLVvz/6zaCioe8Vk50x1QdlHJDFp4thYzPj5v"
  }
]
```

<aside class="warning">It is very important that in order for this documentation to work, you must have requested access to the API and recieved the following information: </aside>

Key | Value | Description
--------- | ------- | -----------
grant_type | password | This value is constant.
client_id | ????? | Once you've been approved to use our API you'll receive this value.
client_secret | ?????| Once you've been approved to use our API you'll receive this value.
username | ????? | Once you've been approved to use our API you'll receive this value.
password | ????? | Once you've been approved to use our API you'll receive this value.
scope | ????? | Once you've been approved to use our API you'll receive this value.

Once you have the values described above you can make the API calls using your <code>access_token</code> and the <code>token_type</code> .
To help with your development use Postman and add the following [Collection](http://example.com/developers).

DNA API expects for the <code>token_type</code> and <code>access_token</code> to be included in all API requests to the server in a header that looks like the following:

`Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2`

<aside class="notice">
You must replace <code>`values`</code> with your provided values. and add the <code>token_type</code> and <code>access_token</code> as values for the <code>Authorization</code>headers for all your API calls.
Additionally use the <code>Accept:application/json</code> Headers for every API call.
</aside>

# Client

## Create a Client

> To Create a new client, use this code:

```shell
curl "https://staging.api.nexogy.com/api/residential/client?email=<value>&
first_name=<value>&last_name=<value>&zipcode=<value>&address=<value>&sameBillingAddress=<values>&billing_zipcode=<value>&billing_address=<value>&has_subreseller_id=<value>&subreseller_id=<value>&start_billing_date=<value>&did_porting=<value>&did_number=<value>"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/client';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Populate array with parameters
$data['email'] = 'example@mail.com';
$data['first_name'] = 'John';
$data['last_name'] = 'Doe';
$data['zipcode'] = '12345';
$data['address'] = 'Client address';
$data['sameBillingAddress'] = 1;
$data['has_subreseller_id'] = 1;
$data['subreseller_id'] = '123';
$data['billing_zipcode'] = '12345';
$data['start_billing_date'] = '06/08/2017';
$data['did_porting'] = 0;
$data['did_number'] = '3052304777';

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);
curl_setopt($c, CURLOPT_POSTFIELDS, http_build_query($data));

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "client": {
      "id": 92769,
      "ns_domain": "kerryking2.com"
    }
  }
}
```

This endpoint creates a Client on DNA. You will get back a <code>id</code> and a <code>ns_domain</code> these will be required for other operations. 

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/client?email=<value>&
first_name=<value>&last_name=<value>&zipcode=<value>&address=<value>&sameBillingAddress=<values>&billing_zipcode=<value>&billing_address=<value>&has_subreseller_id=<value>&subreseller_id=<value>&start_billing_date=<value>&did_porting=<value>&did_number=<value>`

### Query Parameters

<aside class="warning">This request has no default parameters or values. Ignoring this will result in an error.</aside>

Parameter | Example | Description
--------- | ------- | -----------
start_billing_date | 05/29/2017 | Date in  MM/DD/YYYY Format for Billing purposes
customer_id | 1234 | Customer id you use on your side.
has_subreseller_id | 1 | This is an id used to group your client's IDs under a subreseller account if you have resellers that handle your clients this is how we would identify them for consolidation purposes. Accepts 1 or 0.
subreseller_id | 1234 | Send this parameter only if you use a subreseller structure.
email | email@email.com | Email used for any information required for the client, for example to send received V-mail.
first_name | Steve | First name for the client.
last_name | Harris | Last name for the client.
zipcode | 33134 | The client's zipcode.
address | 126 Mendoza avenue aparment 7A | The client's address.
sameBillingAddress | 1 | Accepts 1 or 0 and determines if the address parameter will be used for billing, when 0 <code>billing_address</code> and <code>billing_zipcode</code> are required.
billing_address | 2121 ponce de leon | The billing address.
billing_zipcode | 33308 | The billing zipcode.
did_porting | 0 | Acepts 1 or 0 depending on if the did_number you are providing is ported or no.
did_number | 3052304999 | Main phone number for the client.

<aside class="success">
Remember — store your <code>&lt;id&gt;</code> and <code>&lt;ns_domain&gt;</code> for future operations!
</aside>

## Activate a Client

```shell
curl "https://staging.api.nexogy.com/api/residential/client/<id>/activate"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/client/id/activate';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>

```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "timestamp": 1496930642
  }
}

```

This endpoint activates a specific client. If the client was previously cancelled, it activates the client on Netsapiens and sets the billing_status to active on DNA.

<aside class="warning">You will need the <code>&lt;id&gt;</code> for this operation</aside>

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/client/<id>/activate`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the client to activate,the one we sent you when the client was created

## Suspend a Client

```shell
curl "https://staging.api.nexogy.com/api/residential/client/<id>/suspend"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/client/id/suspend';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "timestamp": 1496940922
  }
}
```

This endpoint suspends a Client. It just locked the client on Netsapiens. This is different from the cancel endpoint.

<aside class="warning">You will need the <code>&lt;id&gt;</code> for this operation</aside>

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/client/<id>/suspend`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the client to suspend, the one we sent you when the client was created

## Cancel a Client

```shell
curl "https://staging.api.nexogy.com/api/residential/client/<id>/cancel"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/client/id/cancel';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "timestamp": 1496931834
  }
}
```

This endpoint cancels a Client. It performs two operations, first suspends the client domain on Netsapiens and then set the billing_status of the client to suspended.

<aside class="warning">You will need the <code>&lt;id&gt;</code> for this operation</aside>

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/client/<id>/cancel`

### URL Parameters

Parameter | Description
--------- | -----------
id | The ID of the client to cancel, the one we sent you when the client was created

## Get Status

```shell
curl "https://staging.api.nexogy.com/api/residential/domain/<domain>"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/domain/<domain>';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "status": "active",
    "timestamp": 1496259363
  }
}
```

This endpoint gets the status of a domain. Status are locked or active

<aside class="warning">You will need the <code>&lt;domain&gt;</code> for this operation</aside>

### HTTP Request

`GET https://staging.api.nexogy.com/api/residential/domain/<domain>`

### URL Parameters

Parameter | Description
--------- | -----------
domain | The domain name of the client.

## Update

```shell
curl "https://staging.api.nexogy.com/api/residential/client/<id>"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/client/<id>';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Populate array with parameters
$data['start_billing_date'] = '06/08/2017';

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);
curl_setopt($c, CURLOPT_POSTFIELDS, http_build_query($data));

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "timestamp": 1496941963
  }
}
```

This endpoint updates the information of a client in DNA. For now it's only available for the start_billing_date field.

<aside class="warning">You will need the <code>&lt;id&gt;</code> for this operation</aside>

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/client/<id>`

### URL Parameters

Parameter | Example | Description
--------- | ------- | -----------
start_billing_date | 06/08/2017 | Date in  MM/DD/YYYY Format for Billing purposes.

# Device

Once a Client is Created a default device is created, additional devices may be created later, with the device method.

## Device method

```shell
curl "https://staging.api.nexogy.com/api/residential/device?client_id=<value>&domain=<value>&ext=<value>"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/residential/device';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Populate array with parameters
$data['domain'] = '06/08/tomaraya.com';
$data['client_id'] = '12345';
$data['ext'] = '1003';

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);
curl_setopt($c, CURLOPT_POSTFIELDS, http_build_query($data));

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>

> The above command returns JSON structured like this:

```json
{
 "result": "OK",
 "data": {
   "subscriber_name": "1012",
   "aor": "sip:1012@kirkhammet.com",
   "domain": "kirkhammet.com",
   "authentication_key": "encrypted key",
   "regservers": {
     "server1": {
       "address": "sandbox.nexogy.net",
       "port": "5092"
     }
   },
   "timestamp": 1496682921
 }
}
```

The Device method behaves different according to the parameters it receives. You can pass the domain or the client_id, no need to pass both. If no ext is sent the default extension is created, in this case extension=1000 and the device information is returned. If a number is sent in this parameter and the device exists this method returns device information. If a number is sent and the device doesn't exist, that device for that extension is created.

### HTTP Request

`POST https://staging.api.nexogy.com/api/residential/device?client_id=<value>&domain=<value>&ext=<value>`

### URL Parameters

Parameter | Description
--------- | -----------
client_id | The client ID of the requested device. You get this information whe the client was created.
domain | The domain you received when the client was created.
extension | This parameter is optional. This is the extension of the customer's device. If no device is sent the default extension is created, in this case extension=1000 and the device information is returned. If a number is sent in this parameter and the device exists this method returns device information. If a number is sent and the device doesn't exist, that device for that extension is created.

### JSON Response

Parameter | Description
--------- | -----------
subscriber_name | The Devices extension number.
aor | The identifier of device and The domain.
authentication_key | The SIP password for the device. For security reasons we use gpg for encryption. You will recieve this parameter encrypted in Base 64 using gpg. With the Public Key you previously sent to us.
regservers | an array with the available registration servers and ports, this is required for your configuration.

Refer to this documentation in order to generate the key here:

<a href='https://help.github.com/articles/generating-a-new-gpg-key/'>Documentation for gpg</a>

<aside class="warning">Send us the public key indicated in step 13 of the <code>gpg</code> documentation found above. For this operation.</aside>

# Did

## Search Dids

```shell
curl "https://staging.api.nexogy.com/api/dids/search?npa=<value>&state=<value>"
  -H "Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY1N2"
  -H "Accept:application/json"
```

```php
<?
// Set api url
$apiUrl = 'https://staging.api.nexogy.com/api/dids/search';
// Start cURL
$c = curl_init();
curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($c, CURLOPT_RETURNTRANSFER, true);

// Populate array with parameters
$data['npa'] = '305';
$data['state'] = 'FL';

// Set up headers
$request_headers = array();
$request_headers[] = 'Authorization: Bearer '. $access_token;
$request_headers[] = 'Accept: application/json';
curl_setopt($c, CURLOPT_HTTPHEADER, $request_headers);

// Setup the remainder of the cURL request
curl_setopt($c, CURLOPT_URL, $apiUrl);
curl_setopt($c, CURLOPT_POST, true);
curl_setopt($c, CURLOPT_POSTFIELDS, http_build_query($data));

// Execute the API call and return the response
$result = curl_exec($c);
curl_close($c);
?>
```

> The above command returns JSON structured like this:

```json
{
  "result": "OK",
  "data": {
    "return": {
      "npas": {
        "npa": "305"
      },
      "quantity": 6,
      "consecutive": 1,
      "result": {
        "tn": [
          {
            "number": 3052304666,
            "category": "Vanity"
          },
          {
            "number": 3052304777,
            "category": "Vanity"
          },
          {
            "number": 3052304999,
            "category": "Vanity"
          },
          {
            "number": 3054344555,
            "category": "Vanity"
          },
          {
            "number": 3054344600,
            "category": "Vanity"
          },
          {
            "number": 3054344777,
            "category": "Vanity"
          }
        ]
      },
      "tnCount": 6
    }
  }
```

This endpoit conducts a search by area code and state name and returns available did numbers to be used when creating a new client.

### HTTP Request

`POST https://staging.api.nexogy.com/api/dids/search?npa=<value>&state=<value>`

### URL Parameters

Parameter | Description
--------- | -----------
npa | Area code of the desired number.
state | State of the desired number.

