## Update a session

> Example request

```shell
curl -X PATCH \
-H 'Authorization: Bearer <TOKEN>' \
-H 'Content-Type: application/json' \
-d '{
  "need_attention": true,
  "tags": ["detox"],
  "topics": ["product"]
}' \
https://api.dirtylemon.com/v1/customers/{CUSTOMER_ID}/sessions/current
```

```javascript
const dirtylemon = require('dirtylemon');

dirtylemon.sessions.update({CUSTOMER_ID}, {
  need_attention: true,
  tags: ["detox"],
  topics: ["product"]
})
```

> Example response

```http
HTTP/1.1 200 OK
```

```json
{
  "id": "7cb0a876-5d34-4e03-b725-932606041626",
  "customer_id": "d78c6a9e-ff0a-4fd6-b1cc-d2a31cc002d5",
  "need_attention": true,
  "tags": [
    "detox"
  ],
  "topics": [
    "product"
  ],
  "messages": [
    {
      "id": "4bada73e-14f2-4306-9752-51b4008251a4",
      "session_id": "7cb0a876-5d34-4e03-b725-932606041626",
      "content": "Need help?",
      "content_type": "text",
      "sender_role": "agent",
      "sent_at": "2017-05-24T19:32:54.060Z",
      "created_at": "2017-05-24T19:32:54.062Z"
    }
  ],
  "created_at": "2017-05-24T19:32:54.048Z",
  "updated_at": "2017-05-24T20:00:00.929Z"
}
```

This endpoint updates a session.

Updating the `need_attention` attribute to `true`:

  - Notifies a human agent to take action

Note that `current` session means a session with a message sent in the last 2 hours. If the customer has no current session, a 404 will be returned.


### HTTP Request

`PATCH https://api.dirtylemon.com/v1/customers/:customer_id/sessions/current`

### Path params

| Parameter | Required | Description |
| --------- | -------- | ------------|
| customer_id | yes |  |

### Body params

| Parameter          | Required | Description |
| ------------------ | -------- | ------------|
| need_attention     | false | |
| tags               | false | Array of tags. Will erase existing values. |
| topics             | false | Array of topics. Will erase existing values. |

### Returns

A session object.
