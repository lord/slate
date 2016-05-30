# KuzzleDocument

Kuzzle handles documents, either as realtime messages or as stored documents. KuzzleDocument is the object representation of one of these documents.

## Constructors

```js
/*
 Constructors are not exposed in the JS/Node SDK.
 KuzzleDocument objects are returned by various KuzzleDataCollection methods.

 You may also use the KuzzleDataCollection.documentFactory() method:
 */
var document = kuzzle.dataCollectionFactory('index', 'collection').documentFactory('id');

var document = kuzzle
  .dataCollectionFactory('index', 'collection')
  .documentFactory({content: 'some content'});

var document = kuzzle
  .dataCollectionFactory('index', 'collection')
  .documentFactory('id', {content: 'some content'});
```

```java
KuzzleDocument document = new KuzzleDocument(collection);

KuzzleDocument document = new KuzzleDocument(collection, "id");

JSONObject content = new JSONObject();
content.put("content", "some content");
KuzzleDocument document = new KuzzleDocument(collection, content);

KuzzleDocument document = new KuzzleDocument(collection, "id", content);
```

```objective_c
KuzzleDocument* document = [[KuzzleDocument alloc] initWithCollection: collection];

KuzzleDocument* document = [[KuzzleDocument alloc] initWithCollection: collection documentId: @"documentId"];

NSDictionary* content = @{
                          @"content": @"some content"
                          };

KuzzleDocument* document = [[KuzzleDocument alloc] initWithCollection: collection content: content];

KuzzleDocument* document = [[KuzzleDocument alloc] initWithCollection: collection documentId: @"documentId" content: content];
```

```swift
let document = KuzzleDocument(collection: dataCollection)

let document = KuzzleDocument(collection: dataCollection, documentId: "documentId")


let content = ["content": "some content"]

let document = KuzzleDocument(collection: dataCollection, content: content)

let document = KuzzleDocument(collection: dataCollection, documentId: "documentId", content: content)
```

#### KuzzleDocument(KuzzleDataCollection, [documentId], [content])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``KuzzleDataCollection`` | object | An instanciated KuzzleDataCollection object |
| ``content`` | JSON Object | Initializes this document with the provided content |
| ``documentId`` | string | ID of an existing document. |

**Note:**  this constructor won't make any call to Kuzzle. When providing only a document ID, the `refresh` method should be called to retrieve the corresponding document content.

## Properties

| Property name | Type | Description | get/set |
|--------------|--------|-----------------------------------|---------|
| ``collection`` | string | The data collection associated to this document | get |
| ``content`` | JSON Object | The content of the document | get/set |
| ``headers`` | JSON Object | Common headers for all sent documents. | get/set |
| ``id`` | string | Unique document identifier | get/set |
| ``version`` | integer | Current document version | get |

**Notes:**  

* setting a new value to the ``content`` property is equivalent to calling ``setContent(data, false)``
* setting a new value to the ``id`` property will force this value for this document
* the ``headers`` property is inherited from the provided ``KuzzleDataCollection`` object and can be overrided

## delete

```js
// Using callbacks (NodeJS or Web Browser)
document.delete(function (error, result) {
  // called once the delete action has been completed
});

// Using promises (NodeJS)
document.deletePromise().then(result => {
  // called once the delete action has been completed
});
```

```java
document.delete(new KuzzleResponseListener<KuzzleDocument>() {
    @Override
    public void onSuccess(KuzzleDocument object) {
      // called once the delete action has been completed
    }

    @Override
    public void onError(JSONObject error) {
      // Handle error
    }
});
```

```objective_c
NSError* error = nil;
[document deleteAndReturnError: &error callback:^(NSString * deletedDocumentId, NSError * error) {
  if(error) {
    // error occured
  }
  // everything went fine
}];

if(error) {
  // NSError reprsentation for KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

```swift
do {
  try document.delete(callback: { result in
      switch result {
        case let .onError(error):
        // error occured during call, error is NSError
        break
        case let .onSuccess(success):
        // everything went fine, success is string with id of deleted KuzzleDocument
        break
      }
  })
} catch {
  // KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}

```

Deletes this document in Kuzzle.

#### delete([options], [callback])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``options`` | JSON Object | Optional parameters |
| ``callback`` | function | Optional callback |

Available options:

| Option | Type | Description | Default |
|---------------|---------|----------------------------------------|---------|
| ``metadata`` | JSON Object | Additional information passed to notifications to other users | ``null`` |
| ``queuable`` | boolean | Mark this request as (not) queuable | ``true`` |

#### Callback response

Resolves to the deleted document ID


## publish

```js
document.publish();
```

```java
document.publish();
```

```objective_c
NSError* error = nil;
[document publishAndReturnError: &error];
if(error) {
  // NSError reprsentation for KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

```swift
do {
  try document.publish()
} catch {
  // KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

Publishes the content of this document as a realtime message.

#### publish([options])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``options`` | JSON Object | Optional parameters |

Available options:

| Option | Type | Description | Default |
|---------------|---------|----------------------------------------|---------|
| ``metadata`` | JSON Object | Additional information passed to notifications to other users | ``null`` |
| ``queuable`` | boolean | Mark this request as (not) queuable | ``true`` |

#### Return value

Returns this `KuzzleDocument` object to allow chaining.


## refresh

```js
// Using callbacks (NodeJS or Web Browser)
document.refresh(function (error, result) {
  // called once the refresh action has been completed
});

// Using promises (NodeJS)
document.refreshPromise().then(result => {
  // called once the refresh action has been completed
});
```

```java
document.refresh(new KuzzleResponseListener<KuzzleDocument>() {
    @Override
    public void onSuccess(KuzzleDocument object) {
      // called once the refresh action has been completed
    }

    @Override
    public void onError(JSONObject error) {
      // Handle error
    }
});
```

```objective_c
NSError* error = nil;
[document refreshAndReturnError: &error callback: ^(KuzzleDocument * document, NSError * error) {
  if(error) {
    // error occured
  }
  // everything went fine
}];

if(error) {
  // NSError reprsentation for KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

```swift
do {
  try document.refresh(callback: { result in
      switch result {
        case let .onError(error):
        // error occured during call, error is NSError
        break
        case let .onSuccess(success):
        // everything went fine, success is KuzzleDocument object
        break
      }
  })
} catch {
  // KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

Creates a new `KuzzleDocument` object with the last version of this document stored in Kuzzle.

#### refresh([options], callback)

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``options`` | JSON Object | Optional parameters |
| ``callback`` | function | Callback |


Available options:

| Option | Type | Description | Default |
|---------------|---------|----------------------------------------|---------|
| ``queuable`` | boolean | Mark this request as (not) queuable | ``true`` |


#### Callback response

Resolves to a new `KuzzleDocument` object containing the last document version.


## save

```js
// Using callbacks (NodeJS or Web Browser)
document.save(function (error, result) {
  // called once the save action has been completed
});

// Using promises (NodeJS)
document.savePromise().then(result => {
  // called once the save action has been completed
});
```

```java
document.save(new KuzzleResponseListener<KuzzleDocument>() {
    @Override
    public void onSuccess(KuzzleDocument object) {
      // called once the save action has been completed
    }

    @Override
    public void onError(JSONObject error) {
      // Handle error
    }
});
```

```objective_c
NSError* error = nil;
[document saveAndReturnError: &error callback:^(KuzzleDocument * document, NSError * error) {
  if(error) {
    // error occured
  }
  // everything went fine
}];

if(error) {
  // NSError reprsentation for KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

```swift
do {
  try document.save(callback: { result in
      switch result {
        case let .onError(error):
        // error occured during call, error is NSError
        break
        case let .onSuccess(success):
        // everything went fine, success is KuzzleDocument object
        break
      }
  })
} catch {
  // KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

Saves this document into Kuzzle.

If this is a new document, this function will create it in Kuzzle and the ``id`` property will be made available.  
Otherwise, this method will replace the latest version of this document in Kuzzle by the current content of this object.

#### save([options], [callback])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``options`` | JSON Object | Optional parameters |
| ``callback`` | function | Optional callback |

Available options:

| Option | Type | Description | Default |
|---------------|---------|----------------------------------------|---------|
| ``metadata`` | JSON Object | Additional information passed to notifications to other users | ``null`` |
| ``queuable`` | boolean | Mark this request as (not) queuable | ``true`` |

#### Return value

Returns this `KuzzleDocument` object to allow chaining.

#### Callback response

Resolves to this `KuzzleDocument` object once the document has been saved.



## setContent

```js
document.setContent({newContent: 'someValue'}, true);
```

```java
JSONObject content = new JSONObject().put("content", "some content");

document.setContent(content, true);
```

```objective_c
NSDictionary* content = @{
  @"content": @"some content"
};

[document setContentWithData: content replace: YES];
```

```swift
let content = [
    "content": "some content"
]
document.setContent(content: content, replace: true)
```

<aside class="notice">
Changes made by this function won't be applied until the <code>save</code> method is called
</aside>

Replaces the current content with new data.  
This is a helper function returning itself, allowing to easily chain calls.

#### setContent(data, [replace])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``data`` | JSON Object | New content |
| ``replace`` | boolean | true: replace the current content with the provided data, false: merge it |

**Note:** by default, the ``replace`` argument is set to ``false``

#### Return value

Returns this `KuzzleDocument` object to allow chaining.

## setHeaders

```js
document.setHeaders({someContent: 'someValue'}, true);
```

```java
JSONObject headers = new JSONObject().put("someContent", "someValue");

document.setHeaders(headers, true);
```

```objective_c
NSDictionary* headers = @{
  @"someContent": @"someValue",
  @"metadata": @{
    @"someMetaData": @[
      @"with",
      @"some",
      @"values"
      ]
    }
  };
[document setHeadersWithData: headers replace: YES];
```

```swift
let headers = [
  "someContent": "someValue",
  "metadata": [
    "someMetaData": [
     "with",
      "some",
      "values"
    ]
  ]
]
document.setHeaders(headers, true);
```

This is a helper function returning itself, allowing to easily chain calls.

#### setHeaders(content, [replace])

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``content`` | JSON Object | New content |
| ``replace`` | boolean | true: replace the current content with the provided data, false: merge it |

**Note:** by default, the ``replace`` argument is set to ``false``

#### Return value

Returns this `KuzzleDocument` object to allow chaining.

## subscribe

```js
var room = document.subscribe(function (error, notification) {
  // called each time a change occurs on this document
});

var room = document.subscribe(
  {subscribeToSelf: true, metadata: { myId: 'someId'}},
  function (error, notification) {
    // called each time a change occurs on this document
  });
```

```java
KuzzleRoom room = document.subscribe(new KuzzleResponseListener<KuzzleNotificationResponse>() {
    @Override
    public void onSuccess(KuzzleNotificationResponse object) {
      // called each time a change occurs on this document
    }

    @Override
    public void onError(JSONObject error) {
      // Handle error
    }
});
```

```objective_c
NSError* error = nil;
KuzzleRoom* room = [document subscribeAndReturnError: &error callback:^(KuzzleNotification * notification, NSError * error) {
  if(error) {
    // error occured
  }
  // everything went fine
}];
if(error) {
  // NSError reprsentation for KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

```swift
do {
  let room = try document.subscribe(callback: { result in
      switch result {
        case let .onError(error):
        // error occured during call, error is NSError
        break
        case let .onSuccess(success):
        // everything went fine, success is KuzzleNotification object
        break
      }
  })
} catch {
  // KuzzleError.IllegalState, when Kuzzle state is .DISCONNECTED
}
```

Listens to changes occuring on this document.
Throws an error if this document has not yet been created in Kuzzle.

#### subscribe([options], callback)

| Arguments | Type | Description |
|---------------|---------|----------------------------------------|
| ``options`` | object | Subscription configuration. Passed to the KuzzleRoom constructor. |
| ``callback`` | function | Callback that will be called each time a change has been detected on this document |

#### Return value

Returns a new `KuzzleRoom` object.
