---
title: API Reference

language_tabs:
  - shell: cURL
  - python: Python
  - javascript: JavaScript

toc_footers:
  - <a href='https://dashboard.scaleapi.com/signup'>Signup for Scale</a>
  - <a href="https://chat.scaleapi.com/">Join the Scale Support Slack channel!</a>

includes:
  - errors

search: true
---

# Introduction

> API Endpoint

```
https://api.scaleapi.com/v1/
```

Welcome to the Scale API! You can use our API to access Scale API endpoints, which can create, access, and cancel human tasks.

Anyone can use our API! [Sign up here](https://dashboard.scaleapi.com/signup) to get started using Scale. You can also [contact us](mailto:hello@scaleapi.com) for volume pricing or any inquiries.

You can also join our [Slack channel here](https://chat.scaleapi.com/)!

<!-- We have language bindings in Shell, Ruby, and Python! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.
 -->

# Client Libraries / SDKs

We're working hard to build official client libraries as quickly as possible! We intend on releasing SDKs soon for the following languages:

* JavaScript
* Python

We also have unnoficial SDKs in the following languages:

* [Ruby](https://github.com/wikiti/scaleapi-ruby) (thanks to [wikiti](https://github.com/wikiti)!)
* [Android SDK](https://github.com/vanshg/Scale) (thanks to [vanshg](https://github.com/vanshg)!)

[Let us know](mailto:hello@scaleapi.com) if you want (or are interested in writing) a library for a language not represented here, or if you’re eagerly waiting for us to get our JavaScript/Python SDKs out the door!

# Authentication

> To authorize, use this code:

```shell
# With curl, you can just pass the correct header with each request
curl "api_endpoint_here" \
  -u "{{ApiKey}}:"
```

```python
import requests

requests.get('api_endpoint_here', auth=('{{ApiKey}}', ''))
```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

request.get('api_endpoint_here', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  }
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> <span ng-if="!user.testApiKey">You must replace <code>{{ApiKey}}</code> with your personal API key. If you <a href="https://dashboard.scaleapi.com/signup">sign up</a> or <a href="https://dashboard.scaleapi.com/login">log in</a>, your API key will be automatically filled in the docs.</span>
> <span ng-if="user.testApiKey">Your test API key <code>{{ApiKey}}</code> is included in all the examples on this page, so you can test any example right away. Only you can see this value.</span>

Scale uses API keys to allow access to the API. You can find your API keys on your [dashboard](https://dashboard.scaleapi.com/dashboard), which you can access by [logging in](https://dashboard.scaleapi.com/login) or [signing up](https://dashboard.scaleapi.com/signup).

Scale expects for the API key to be included in all API requests to the server via [HTTP Basic Auth](http://en.wikipedia.org/wiki/Basic_access_authentication). Provide your API key as the basic auth username value. You do not need to provide a password. You can do this using the `-u` flag:

`-u "{{ApiKey}}:"`

<aside class="notice" ng-if="!user.testApiKey">
You must replace <code>{{ApiKey}}</code> with your personal API key. If you <a href="https://dashboard.scaleapi.com/signup">sign up</a> or <a href="https://dashboard.scaleapi.com/login">log in</a>, your API key will be automatically filled in the docs.
</aside>

<aside class="notice" ng-if="user.testApiKey">
Your test API key <code>{{ApiKey}}</code> is included in all the examples on this page, so you can test any example right away. Only you can see this value.
</aside>

### Test and Live Modes

To make the API as explorable as possible, accounts have test mode and live mode API keys. There is no "switch" for changing between modes, just use the appropriate key to perform a live or test API requests.

Requests made with test mode credentials are not completed by a human, and therefore have incorrect test responses. Requests made with live mode credentials are always completed by a human, and will incur a charge past your first 5 API requests.

### Callback Authentication

If you'd like to authenticate our callbacks, we set a `scale-callback-auth` HTTP header on each of our callbacks. The value will be equal to your `Live Callback Auth Key` shown on your dashboard. If this header is not set, or it is set incorrectly, the callback is not from Scale.

# Task Object

The task object represents a single task that you create with Scale and is completed by a worker.

## Attributes

```json
{
  "task_id": "576ba74eec471ff9b01557cc",
  "completed_at": "2016-06-23T09:10:02.798Z",
  "created_at": "2016-06-23T09:09:34.752Z",
  "callback_url": "http://www.example.com/callback",
  "type": "categorization",
  "status": "completed",
  "instruction": "Would you say this item is big or small?",
  "urgency": "immediate",
  "params": {
    "attachment_type": "text",
    "attachment": "car",
    "categories": [
      "big",
      "small"
    ]
  },
  "response": {
    "category": "big"
  },
  "metadata": {}
}
```

Attribute | Type | Description
--------- | ------- | -----------
`task_id` | string | The `task_id` is the unique identifier for the task.
`type` | string | The type of the task. Currently, we support `categorization`, `transcription`, `phonecall`, and `comparison`.
`instruction` | string | A markdown-enabled string explaining the instructions for the task. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`params` | object | An object with the parameters of the task based on the type. For `categorization`, for example, this will include `attachment_type`, `attachment`, and `categories`.
`urgency` | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one-hour response time.
`response` | object | An object corresponding to the response once the task is completed. For `categorization`, it will have the attribute `category`, corresponding to the chosen category.
`callback_url` | string | A string of the URL that should be POSTed once the task is completed for the response data. See the Callback section for more details.
`status` | string | The status of the task, one of `pending`, `completed`, or `canceled`.
`created_at` | timestamp | A string of the UTC timestamp of when the task was created.
`completed_at` | timestamp | A string of the UTC timestamp of when the task was completed. This will only be filled in after it is completed.
`metadata` | object, default `{}` | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Metadata

Tasks objects have a metadata parameter. You can use this parameter to attach key-value data to tasks.

Metadata is useful for storing additional, structured information on an object. As an example, you could store a video's unique identifier in your system on its content moderation `categorization` task. You can also use it to denote the end use case for the task, as "content moderation" or "data categorization" for example. Metadata is not used by Scale (e.g., to affect how the task is done).

# Create Categorization Task

```shell
curl "https://api.scaleapi.com/v1/task/categorize" \
  -u "{{ApiKey}}:" \
  -d callback_url="http://www.example.com/callback" \
  -d instruction="Is this company public or private?" \
  -d attachment_type=website \
  -d attachment="http://www.google.com/" \
  -d categories=public \
  -d categories=private
```

```python
import requests

payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Is this company public or private?',
  'attachment_type': 'website',
  'attachment': 'http://www.google.com/',
  'categories': ['public', 'private']
}

requests.post("https://api.scaleapi.com/v1/task/categorize", 
  json=payload, 
  auth=('{{ApiKey}}', ''))

```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Is this company public or private?',
  'attachment_type': 'website',
  'attachment': 'http://www.google.com/',
  'categories': ['public', 'private']
};

request.post('https://api.scaleapi.com/v1/task/categorize', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  },
  'form': payload
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "576ba74eec471ff9b01557cc",
  "created_at": "2016-06-23T09:09:34.752Z",
  "callback_url": "http://www.example.com/callback",
  "type": "categorization",
  "status": "pending",
  "instruction": "Is this company public or private?",
  "urgency": "day",
  "params": {
    "attachment_type": "website",
    "attachment": "http://www.google.com/",
    "categories": [
      "public",
      "private"
    ]
  },
  "metadata": {}
}
```

This endpoint creates a `categorization` task. In this task, one of our workers will view the attachment and choose a category for it according to the instruction. You may allow multiple categories to be chosen by setting `allow_multiple` to `true`. Example use cases are spam detection, copyright detection, product categorization, etc.

This task involves a [markdown-enabled](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) `instruction` about how to make the categorization, an `attachment` of what you'd like to categorize, an `attachment_type`, and finally a list of `categories`. 

There is an optional `category_ids` parameter, which you can use to impose an id system over the categories. The format of this parameter should be a dictionary, where the keys are the ids (as strings), and then the values are the category values provided in `categories`. An example is:

```"category_ids": {
  "123": "Blue Cross",
  "124": "Red Cross"
}```

If successful, Scale will immediately return the generated task object, of which you should at least store the `task_id`.

The parameters `attachment_type`, `attachment`, `categories`, and `category_ids` (optional) will be stored in the `params` object of the constructed `task` object.

### HTTP Request

`POST https://api.scaleapi.com/v1/task/categorize`

### Parameters

Parameter | Type | Description
--------- | ---- | -------
`callback_url` | string | The full url (including the scheme `http://` or `https://`) of the callback when the task is completed.
`instruction` | string | A markdown-enabled string explaining how to categorize the item. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`attachment_type` | string | One of `text`, `image`, `video`, `audio`, `website`, or `pdf`. Describes what type of file the attachment is.
`attachment` | string | The attachment to be categorized. If `attachment_type` is `text`, then it should be plaintext. Otherwise, it should be a URL pointing to the attachment.
`categories` | [string] | An array of strings for the categories which you'd like the object to be sorted between.
`urgency` (optional, default `day`) | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one-hour response time.
`category_ids` (optional) | dictionary | An optional dictionary where the keys are the optional ids, and the values are the category values provided in `categories`.
`allow_multiple` (optional) | boolean | Default is `false`. Determines whether you allow multiple categories to be chosen for the attachment
`metadata` (optional, default `{}`) | object | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Response on Callback

> If `allow_multiple` is `false`, the `response` will look like:

```json
{
  "category": "one_of_the_categories"
}
```
> If `allow_multiple` is `true`, the `response` will look like:

```json
{
  "category": ["some_of", "the_categories"]
}
```
> Example if `category_ids` is provided and `allow_multiple` is `false`

```json
{
  "category": "Blue Cross",
  "category_id": "123"
}
```
> Example if `category_ids` is provided and `allow_multiple` is `true`

```json
{
  "category": ["Blue Cross", "Red Cross"],
  "category_id": ["123", "124"]
}
```

The `response` object, which is part of the callback POST request and permanently stored as part of the task object, will have a `category` field and potentially a `category_id` field.

If `allow_multiple` is `false`, then the value will be a string equal to one of the original categories. 

If `allow_multiple` is `true`, the value will be an array of categories, each one being one of the original categories.

If `category_ids` was provided, there will be another field `category_id` corresponding to the given id of the chosen category/categories. For example, it could look like:

# Create Transcription Task

```shell
curl "https://api.scaleapi.com/v1/task/transcription" \
  -u "{{ApiKey}}:" \
  -d callback_url="http://www.example.com/callback" \
  -d instruction="Transcribe the given fields. Then for each news item on the page, transcribe the information for the row." \
  -d attachment_type=website \
  -d attachment="http://www.google.com/" \
  -d fields[title]="Title of Webpage" \
  -d fields[top_result]="Title of the top result" \
  -d row_fields[username]="Username of submitter" \
  -d row_fields[comment_count]="Number of comments"
```

```python
import requests
import json

payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Transcribe the given fields. Then for each news item on the page, transcribe the information for the row.',
  'attachment_type': 'website',
  'attachment': 'http://www.google.com/',
  'fields': {
    'title': 'Title of Webpage',
    'top_result': 'Title of the top result'
  },
  'row_fields': {
    'username': 'Username of submitter',
    'comment_count': 'Number of comments'
  }
}

headers = {"Content-Type": "application/json"}

requests.post("https://api.scaleapi.com/v1/task/transcription", 
  json=payload, 
  headers=headers,
  auth=('{{ApiKey}}', ''))

```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Transcribe the given fields. Then for each news item on the page, transcribe the information for the row.',
  'attachment_type': 'website',
  'attachment': 'http://www.google.com/',
  'fields': {
    'title': 'Title of Webpage',
    'top_result': 'Title of the top result'
  },
  'row_fields': {
    'username': 'Username of submitter',
    'comment_count': 'Number of comments'
  }
};

request.post('https://api.scaleapi.com/v1/task/transcription', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  },
  'form': payload
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "576de9dc1ea5f917d56fc2a0",
  "created_at": "2016-06-25T02:18:04.248Z",
  "callback_url": "http://www.example.com/callback",
  "type": "transcription",
  "status": "pending",
  "instruction": "Transcribe the given fields. Then for each news item on the page, transcribe the information for the row.",
  "urgency": "day",
  "params": {
    "row_fields": {
      "username": "Username of submitter",
      "comment_count": "Number of comments"
    },
    "fields": {
      "title": "Title of Webpage",
      "top_result": "Title of the top result"
    },
    "attachment": "http://www.google.com/",
    "attachment_type": "website"
  },
  "metadata": {}
}
```

This endpoint creates a `transcription` task. In this task, one of our workers will read an attachment and arbitrarily transcribe any information you'd like. Example use cases could be transcribing information from PDFs, manually scraping a web page for information, etc.

This task involves a [markdown-enabled](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) `instruction` about how to transcribe the attachment, an `attachment` of what you'd like to transcribe, an `attachment_type`, and at least one of `fields` and `row_fields`. `fields` is a dictionary which describes items you'd like transcribed once per attachment, and `row_fields` is a dictionary which describes items which need to be transcribed per row in the attachment.

At least one of `fields` or `row_fields` is required. Both `fields` and `row_fields` are dictionaries where the keys are the keys you'd like the results to be returned under, and values are the descriptions you'd like to show the human worker.

If successful, Scale will immediately return the generated task object, of which you should at least store the `task_id`.

The parameters `attachment_type`, `attachment`, `fields`, and `row_fields` will be stored in the `params` object of the constructed `task` object.

<aside class="notice">
We limit the number of rows you may transcribe per API request to 10 rows. If you need more rows, send multiple API requests.
</aside>

### HTTP Request

`POST https://api.scaleapi.com/v1/task/transcription`

### Parameters

Parameter | Type | Description
--------- | ---- | -------
`callback_url` | string | The full url (including the scheme `http://` or `https://`) of the callback when the task is completed.
`instruction` | string | A markdown-enabled string explaining how to transcribe the attachment. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`attachment_type` | string | One of `text`, `image`, `video`, `audio`, `website`, or `pdf`. Describes what type of file the attachment is.
`attachment` | string | The attachment to be transcribed. If `attachment_type` is `text`, then it should be plaintext. Otherwise, it should be a URL pointing to the attachment.
`fields` (optional if using `row_fields`) | dictionary | A dictionary corresponding to the fields to be transcribed. Keys are the keys you'd like the fields to be returned under, and values are descriptions to be shown to human workers.
`row_fields` (optional if using `fields`) | dictionary | If your transcription requires a transcription of a variable number of row items, then this dictionary describes the fields for these rows. The format is the same as `fields`.
`urgency` (optional, default `day`) | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one-hour response time.
`metadata` (optional, default `{}`) | object | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Response on Callback

> Example response object if both `fields` and `row_fields` are specified

```json
{
  "fields": {
    "title": "Some Title",
    "top_result": "The Top Result or Something"
  },
  "rows": [
    {
      "username": "connaissance",
      "comment_count": "12"
    },
    {
      "username": "alexandr_wang",
      "comment_count": "132"
    }
  ]
}
```

The `response` object, which is part of the callback POST request and permanently stored as part of the task object, will have either a `fields` field, a `rows` field, or both.

`fields` will have keys corresponding to the keys you provided in the parameters, with values the transcribed value. 

`rows` will be an array of such dictionaries, with keys corresponding to the keys you provided in the parameters, and values corresponding to the transcribed value.

# Create Phone Call Task

```shell
curl "https://api.scaleapi.com/v1/task/phonecall" \
  -u "{{ApiKey}}:" \
  -d callback_url="http://www.example.com/callback" \
  -d instruction="Call this person and follow the script provided, recording responses" \
  -d phone_number=5055006865 \
  -d entity_name="Alexandr Wang" \
  -d script="Hello {{name}}! Are you happy today? (pause) One more thing - what is your email address?" \
  -d fields[email]="Email Address" \
  -d choices="He is happy" \
  -d choices="He is not happy"
```
```python
import requests
import json

payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Call this person and follow the script provided, recording responses',
  'phone_number': '5055006865',
  'entity_name': 'Alexandr Wang',
  'script': 'Hello {{name}}! Are you happy today? (pause) One more thing - what is your email address?',
  'fields': {
    'email': 'Email Address',
  },
  'choices': ['He is happy', 'He is not happy']
}

headers = {"Content-Type": "application/json"}

requests.post("https://api.scaleapi.com/v1/task/phonecall", 
  json=payload, 
  headers=headers,
  auth=('{{ApiKey}}', ''))

```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Call this person and follow the script provided, recording responses',
  'phone_number': '5055006865',
  'entity_name': 'Alexandr Wang',
  'script': 'Hello {{name}}! Are you happy today? (pause) One more thing - what is your email address?',
  'fields': {
    'email': 'Email Address',
  },
  'choices': ['He is happy', 'He is not happy']
};

request.post('https://api.scaleapi.com/v1/task/phonecall', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  },
  'form': payload
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "5771bc6631b72659f0d3692b",
  "created_at": "2016-06-27T23:53:10.367Z",
  "callback_url": "http://www.example.com/callback",
  "type": "phonecall",
  "status": "pending",
  "instruction": "Call this person and follow the script provided, recording responses",
  "script": "Hello {{name}}! Are you happy today? (pause) One more thing - what is your email address?",
  "urgency": "day",
  "params": {
    "fields": {
      "email": "Email Address"
    },
    "choices": [
      "He is happy",
      "He is not happy"
    ],
    "entity_name": "Alexandr Wang",
    "phone_number": "5055006865"
  },
  "metadata": {}
}
```

This endpoint creates a `phonecall` task. In this task, one of our workers will call the specified phone number and follow the instructions. Potential use cases could be making reservations or appointments, confirming reservations, asking for contact numbers or emails, etc.

The required parameters are a [markdown-enabled](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) `instruction` about how to transcribe the attachment, a `script` for the Scaler to follow, a `phone_number` for the phone number to call, and an `entity_name` which describes the phone number.

The optional parameters are `attachment_type` and `attachment` for an optional attachment, `fields`, and `choices`.

There are two potential ways to record more information from the phonecall - the `field` and `choices` parameters. `choices` is an array of strings from which the worker to choose, and `fields` is useful for free-text response.

If successful, Scale will immediately return the generated task object, of which you should at least store the `task_id`.

The parameters `phone_number`, `entity_name`, `script`, `attachment_type`, `attachment`, and `fields` will be stored in the `params` object of the constructed `task` object.

<aside class="notice">
For low volume, we currently only support calling US numbers. For higher volume international calls, please <a href="mailto:hello@scaleapi.com">contact us</a>!
</aside>

### HTTP Request

`POST https://api.scaleapi.com/v1/task/phonecall`

### Parameters

Parameter | Type | Description
--------- | ---- | -------
`callback_url` | string | The full url (including the scheme `http://` or `https://`) of the callback when the task is completed.
`instruction` | string | A markdown-enabled string explaining how to complete the phone call. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`phone_number` | string | The phone number which will be called by our worker. Should include a country code (+1 for US numbers).
`script` | string | A script to be shown the the worker as they make the phone call. Your script will greatly impact the quality of the results you receive.
`entity_name` | name | The name of the entity which corresponds to the person or business of the phone number.
`urgency` (optional, default `day`) | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one-hour response time.
`attachment_type` (optional) | string | One of `text`, `image`, `video`, `audio`, `website`, or `pdf`. Describes what type of file the attachment is.
`attachment` (optional) | string | The optional attachment to be used for the phone call. If `attachment_type` is `text`, then it should be plaintext. Otherwise, it should be a URL pointing to the attachment.
`fields` (optional) | dictionary | A dictionary corresponding to the fields to be recorded. Keys are the keys you'd like the fields to be returned under, and values are descriptions to be shown to human workers.
`choices` (optional) | [string] | An array of strings for the choices to be given to the worker. They will choose one of these in accordance with your `instruction`.
`metadata` (optional, default `{}`) | object | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Response on Callback

> Example `response` object:

```json
{
  "outcome": "success",
  "fields": {
    "email": "hello@scaleapi.com"
  },
  "choice": "He is happy"
}
```

The `response` object, which is part of the callback POST request and permanently stored as part of the task object, will have an `outcome` field, and a `fields` field and/or `choice` field depending on the original request.

The outcome will be a string equal to one of `no_pickup` (meaning nobody picked up), `hung_up` (meaning the recipient hung up before the task could be completed), or `success` (the call succeeded). 

If your original API request provided `fields`, `fields` will have keys corresponding to the keys you provided in the parameters, with values the transcribed value.

If your original API request provided `choices`, `choice` will be one of the original choices.


# Create Comparison Task

```shell
curl "https://api.scaleapi.com/v1/task/comparison" \
  -u "{{ApiKey}}:" \
  -d callback_url="http://www.example.com/callback" \
  -d instruction="Do the objects in these images have the same pattern?" \
  -d attachment_type=image \
  -d attachments="http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG" \
  -d attachments="http://images.wisegeek.com/checkered-tablecloth.jpg" \
  -d choices="yes" \
  -d choices="no"
```
```python
import requests
import json

payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Do the objects in these images have the same pattern?',
  'attachment_type': 'image',
  'attachments': [
    'http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG',
    'http://images.wisegeek.com/checkered-tablecloth.jpg'
  ],
  'choices': ['yes', 'no']
}

headers = {"Content-Type": "application/json"}

requests.post("https://api.scaleapi.com/v1/task/comparison", 
  json=payload, 
  headers=headers,
  auth=('{{ApiKey}}', ''))

```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Do the objects in these images have the same pattern?',
  'attachment_type': 'image',
  'attachments': [
    'http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG',
    'http://images.wisegeek.com/checkered-tablecloth.jpg'
  ],
  'choices': ['yes', 'no']
};

request.post('https://api.scaleapi.com/v1/task/comparison', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  },
  'form': payload
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "5774cc78b02487c424f089dd",
  "created_at": "2016-06-30T07:38:32.368Z",
  "callback_url": "http://www.example.com/callback",
  "type": "comparison",
  "status": "pending",
  "instruction": "Do the objects in these images have the same pattern?",
  "urgency": "day",
  "params": {
    "choices": [
      "yes",
      "no"
    ],
    "attachment_type": "image",
    "attachments": [
      "http://i.ebayimg.com/00/$T2eC16dHJGwFFZKjy5ZjBRfNyMC4Ig~~_32.JPG",
      "http://images.wisegeek.com/checkered-tablecloth.jpg"
    ]
  },
  "metadata": {}
}
```

This endpoint creates a `comparison` task. In this task, one of our workers view the given attachments and do any comparison requested.

This task involves a [markdown-enabled](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) `instruction`, an array of `attachments`, and an `attachment_type`.

At least of the `fields` or `choices` parameters must specified for the data to be returned. `choices` is an array of strings from which the worker to choose, and `fields` is useful for free-text response. 

`fields` is a dictionary where the keys are the keys you'd like the results to be returned under, and values are the descriptions you'd like to show the human worker.

If successful, Scale will immediately return the generated task object, of which you should store the `task_id`.

The parameters `attachment_type`, `attachments`, `choices`, and `fields` will be stored in the `params` object of the constructed `task` object.

### HTTP Request

`POST https://api.scaleapi.com/v1/task/comparison`

### Parameters

Parameter | Type | Description
--------- | ---- | -------
`callback_url` | string | The full url (including the scheme `http://` or `https://`) of the callback when the task is completed.
`instruction` | string | A markdown-enabled string explaining how to compare the attachments. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`attachment_type` | string | One of `text`, `image`, `video`, `audio`, `website`, or `pdf`. Describes what type of file the attachments are.
`attachments` | array | An array of attachments to compare. If `attachment_type` is `text`, then each attachment should be plaintext. Otherwise, they should be URLs pointing to the attachments.
`urgency` (optional, default `day`) | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one hour response time.
`fields` (optional) | dictionary | A dictionary corresponding to the fields to be recorded. Keys are the keys you'd like the fields to be returned under, and values are descriptions to be shown to human workers.
`choices` (optional) | [string] | An array of strings for the choices to be given to the worker. One of `choices` or `fields` must be specified.
`metadata` (optional, default `{}`) | object | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Response on Callback

> Example `response` object:

```json
{
  "choice": "yes",
  "fields": {
    "difference": "The patterns are identical."
  }
}
```

The `response` object, which is part of the callback POST request and permanently stored as part of the task object, will have a `fields` field and/or `choice` field depending on the original request.

If your original call provided `choices`, `choice` will be one of the original choices.

If your original call provided `fields`, `fields` will have keys corresponding to the keys you provided in the parameters, with values the transcribed value.

# Create Annotation Task (Bounding Box)

```shell
curl "https://api.scaleapi.com/v1/task/annotation" \
  -u "{{ApiKey}}:" \
  -d callback_url="http://www.example.com/callback" \
  -d instruction="Draw a box around each **baby cow** and **big cow**." \
  -d attachment_type=image \
  -d attachment="http://i.imgur.com/v4cBreD.jpg" \
  -d objects_to_annotate="baby cow" \
  -d objects_to_annotate="big cow" \
  -d with_labels=true
```
```python
import requests
import json

payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Draw a box around each **baby cow** and **big cow**',
  'attachment_type': 'image',
  'attachment': 'http://i.imgur.com/v4cBreD.jpg',
  'objects_to_annotate': ['baby cow', 'big cow'],
  'with_labels': True
}

headers = {"Content-Type": "application/json"}

requests.post("https://api.scaleapi.com/v1/task/annotation", 
  json=payload, 
  headers=headers,
  auth=('{{ApiKey}}', ''))

```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var payload = {
  'callback_url': 'http://www.example.com/callback',
  'instruction': 'Draw a box around each **baby cow** and **big cow**',
  'attachment_type': 'image',
  'attachment': 'http://i.imgur.com/v4cBreD.jpg',
  'objects_to_annotate': ['baby cow', 'big cow'],
  'with_labels': true
}

request.post('https://api.scaleapi.com/v1/task/annotation', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  },
  'form': payload
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "5774cc78b01249ab09f089dd",
  "created_at": "2016-9-03T07:38:32.368Z",
  "callback_url": "http://www.example.com/callback",
  "type": "annotation",
  "status": "pending",
  "instruction": "Draw a box around each **baby cow** and **big cow**",
  "urgency": "day",
  "params": {
    "attachment_type": "image",
    "attachment": "http://i.imgur.com/v4cBreD.jpg",
    "objects_to_annotate": ["baby cow", "big cow"],
    "with_labels": true
  },
  "metadata": {}
}
```

This endpoint creates a `annotation` task. In this task, one of our Scalers view the given image and draw bounding boxes around the specified objects, returning the positions and sizes of these boxes.

The required parameters for this task are `callback_url`, `attachment`, and `objects_to_annotate`. The `callback_url` is the URL which will be POSTed on task completion, and is described in more detail in the [Callbacks section](#callbacks). The `attachment` is a URL to an image you'd like to be annotated.

`objects_to_annotate` is an array of strings describing the different types of objects you'd like annotated.

You can optionally provide additional [markdown-enabled](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) instructions via the `instruction` parameter. 

You can also optionally set `with_labels` to `true`, which will have Scalers provide labels for each box specifying what type of object it is. The labels will be strings in the `objects_to_annotate` list.

If successful, Scale will immediately return the generated task object, of which you should at least store the `task_id`.

### HTTP Request

`POST https://api.scaleapi.com/v1/task/annotation`

### Parameters

Parameter | Type | Description
--------- | ---- | -------
`callback_url` | string | The full url (including the scheme `http://` or `https://`) of the callback when the task is completed.
`objects_to_annotate` | [string] | An array of strings describing which objects you'd like bounding boxes to be drawn around. Each string should be singular and self-descriptive (ex: "cat", "street sign", "potato")
`attachment` | string | A URL to the image you'd like to be annotated with bounding boxes.
`with_labels` (optional, default `false`) | boolean | Specifies whether you'd like labels for each bounding box in the response. Each label will be a member of the `objects_to_annotate` array.
`urgency` (optional, default `day`) | string | A string describing the urgency of the response. One of `immediate`, `day`, or `week`, where `immediate` is a one-hour response time.
`instruction` (optional) | string | A markdown-enabled string explaining how to draw the bounding boxes. You can use [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) to show example images, give structure to your instructions, and more.
`attachment_type` (optional, default `image`) | string | Describes what type of file the attachment is. We currently only support `image` for the annotation endpoint.
`metadata` (optional, default `{}`) | object | A set of key/value pairs that you can attach to a task object. It can be useful for storing additional information about the task in a structured format.

## Response on Callback

> Example of what the response field of the task will look like after completion

```json
{
  "response": {
    "annotations": [
      {
        "left": 123,
        "top": 10,
        "width": 121,
        "height": 39,
        "label": "big cow"
      },
      {
        "left": 82,
        "top": 56,
        "width": 64,
        "height": 30,
        "label": "baby cow"
      },
      { ... },
      { ... }
    ]
  },
  "task_id": "5774cc78b01249ab09f089dd",
  "task": { ... }
}
```

The `response` field, which is part of the callback POST request and permanently stored as part of the `task` object, will contain only an `annotations` field.

The `annotations` field will contain an array of annotations. Each annotation will have the following values:


* `left`: The distance, in pixels, between the left border of the bounding box and the left border of the image.
* `top`: The distance, in pixels, between the top border of the bounding box and the top border of the image.
* `width`: The width, in pixels, of the bounding box.
* `height`: The height, in pixels, of the bounding box.
* `label` (if specified `with_labels` as `true`): The label for the bounding box, which will be one of the specified `task.params.objects_to_annotate`.

# Callbacks

> The `callback_url` will be POSTed with `application/json` data of the following object form:

```json
{
  "task": {
    "task_id": "576c41bf13e36b0600b02b34",
    "completed_at": "2016-06-23T21:54:44.904Z",
    "response": {
      "category": "big"
    },
    "created_at": "2016-06-23T20:08:31.573Z",
    "callback_url": "http://www.example.com/callback",
    "type": "categorization",
    "status": "completed",
    "instruction": "Is this object red or blue?",
    "urgency": "day",
    "params": {
      "attachment_type": "text",
      "attachment": "tomato",
      "categories": [
        "red",
        "blue"
      ]
    },
    "metadata": {}
  },
  "response": {
    "category": "red"
  },
  "task_id": "576c41bf13e36b0600b02b34"
}
```

On your tasks, you will be required to supply a `callback_url`, a fully qualified URL that we will POST with the results of the task when completed. The data will be served as a JSON body (`application/json`). Alternately,
you can set a default callback URL in your profile, which will be used for tasks that do not specify one.

You should respond to the POST request with a 200 status code. If we do not receive a 200 status code, we will retry one more time.

### Getting Started

We have sample callback server implementations, which you can deploy to Heroku in seconds, in the following languages:

* [Node.js](https://github.com/scaleapi/sample-callback-server-node)
* Python (coming soon!)

If you're just testing and want to try a few requests, the easiest way to get started is to use a [RequestBin](http://requestb.in/) and send requests using your `http://requestb.in/someHash` URL as the `callback_url`. You can also use [ngrok](https://ngrok.com/) to expose a local server to the internet for fast prototyping.

Feel free to [chat us on Slack](https://chat.scaleapi.com) or [email us](mailto:hello@scaleapi.com) if you have any trouble.

### Authentication

If you'd like to authenticate our callbacks, we set a `scale-callback-auth` HTTP header on each of our callbacks. The value will be equal to your `Live Callback Auth Key` shown on your dashboard. If this header is not set, or it is set incorrectly, the callback is not from Scale.

### POST Data

Attribute | Type | Description
--------- | ------- | -----------
`task_id` | string | The `task_id` is the unique identifier for the task.
`response` | object | The response object of the completed request. For `categorization`, it will contain a `category` attribute of the assigned category.
`task` | object | The full task object for reference and convenience.


# Task Endpoints

## Retrieve a Task

```shell
curl "https://api.scaleapi.com/v1/task/{task_id}" \
  -u "{{ApiKey}}:"
```

```python
import requests

task_id = 'YOUR_TASK_ID'

response = requests.get('https://api.scaleapi.com/v1/task/%s' % task_id, auth=('{{ApiKey}}', ''))

# Return dictionary can be accessible in this way
response_dict = json.loads(response.content)
```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var task_id = 'YOUR_TASK_ID';

request.get('https://api.scaleapi.com/v1/task/' + task_id + '/', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  }
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "576ba74eec471ff9b01557cc",
  "completed_at": "2016-06-23T09:10:02.798Z",
  "created_at": "2016-06-23T09:09:34.752Z",
  "callback_url": "http://www.example.com/callback",
  "type": "categorization",
  "status": "completed",
  "instruction": "Would you say this item is big or small?",
  "urgency": "day",
  "params": {
    "attachment_type": "text",
    "attachment": "car",
    "categories": [
      "big",
      "small"
    ]
  },
  "response": {
    "category": "big"
  },
  "metadata": {}
}
```

This endpoint retrieves a specific task.

### HTTP Request

`GET https://api.scaleapi.com/v1/task/{TASK_ID}`

### URL Parameters

Parameter | Description
--------- | -----------
`task_id` | The task_id of the task to retrieve

### Returns

Returns a task if a valid identifier was provided, and returns a 404 error otherwise.

## Cancel a task

```shell
curl -X POST "https://api.scaleapi.com/v1/task/{task_id}/cancel" \
  -u "{{ApiKey}}:"
```

```python
import requests
import json

task_id = 'YOUR_TASK_ID'

response = requests.post('https://api.scaleapi.com/v1/task/%s/cancel/' % task_id, auth=('{{ApiKey}}', ''))

# Return dictionary can be accessible in this way
response_dict = json.loads(response.content)
```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

var task_id = 'YOUR_TASK_ID';

request.post('https://api.scaleapi.com/v1/task/' + task_id + '/cancel/', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  }
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "task_id": "576ba74eec471ff9b01557cc",
  "created_at": "2016-06-23T09:09:34.752Z",
  "callback_url": "http://www.example.com/callback",
  "type": "categorization",
  "status": "canceled",
  "instruction": "Would you say this item is big or small?",
  "urgency": "week",
  "params": {
    "attachment_type": "text",
    "attachment": "car",
    "categories": [
      "big",
      "small"
    ]
  },
  "metadata": {}
}
```

This endpoint cancels a task so that it will not be completed.

You may only cancel pending tasks, and the endpoint will return a 500 error code if you attempt to cancel a completed task.

### HTTP Request

`POST https://api.scaleapi.com/v1/task/{TASK_ID}/cancel`

### URL Parameters

Parameter | Description
--------- | -----------
`task_id` | The task_id of the task to cancel

### Returns

Returns the canceled task if a valid identifier for a pending task was provided, and returns a 404 error or 500 error otherwise.

## List All Tasks

```shell
curl "https://api.scaleapi.com/v1/tasks" \
  -u "{{ApiKey}}:"
```

```python
import requests
import json

response = requests.get('https://api.scaleapi.com/v1/tasks/', auth=('{{ApiKey}}', ''))

# Return dictionary can be accessible in this way
response_dict = json.loads(response.content)
```

```javascript
var request = require("request");
var SCALE_API_KEY = '{{ApiKey}}';

request.get('https://api.scaleapi.com/v1/tasks/', {
  'auth': {
    'user': SCALE_API_KEY,
    'pass': '',
    'sendImmediately': true
  }
}, function(error, response, body) {
  if (!error && response.statusCode == 200) {
    console.log(body);
  } else {
    console.log(error);
    console.log(response.statusCode);
  }
});
```

> The above command returns JSON structured like this:

```json
{
  "docs": [
    {
      "task_id": "576b998b4628d1bfaed7d3a4",
      "created_at": "2016-06-23T08:10:51.032Z",
      "callback_url": "http://www.example.com/callback",
      "type": "categorization",
      "status": "completed",
      "instruction": "Is this object big or small?",
      "urgency": "immediate",
      "params": {
        "attachment_type": "text",
        "attachment": "ant",
        "categories": [
          "big",
          "small"
        ]
      },
      "completed_at": "2016-06-23T19:36:23.084Z",
      "response": {
        "category": "small"
      },
      "metadata": {}
    },
    {
      "task_id": "576ba301eed30241b0e9bbf7",
      "created_at": "2016-06-23T08:51:13.903Z",
      "callback_url": "http://www.example.com/callback",
      "type": "categorization",
      "status": "completed",
      "instruction": "Is this object big or small?",
      "urgency": "day",
      "params": {
        "attachment_type": "text",
        "attachment": "T-Rex",
        "categories": [
          "big",
          "small"
        ]
      },
      "completed_at": "2016-06-23T09:09:10.108Z",
      "response": {
        "category": "big"
      },
      "metadata": {}
    }
  ],
  "total": 2,
  "limit": 100,
  "offset": 0,
  "has_more": false
}
```

This endpoint retrieves a list of your tasks.

### HTTP Request

`GET https://api.scaleapi.com/v1/tasks`

### URL Parameters

Parameter | Description
--------- | -----------
`start_time` | The minimum value of created_at for tasks to be returned (ISO 8601 Date)
`end_time`   | The maximum value of created_at for tasks to be returned (ISO 8601 Date)
`status`     | The status of the task - can be: `completed`, `pending`, or `canceled`
`type`       | The type of the task - can be: `transcription`, `categorization`, `phonecall`, `comparison`, `annotation`, `datacollection`, or any other task type.
`limit`      | The maximum number of results to display per page
`offset`     | How many results to skip, for showing the next page

### Returns

Returns a list of your tasks.
