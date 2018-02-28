# Response Codes

MDLIVE returns the following response codes from our API endpoints.

### Response codes list

HTTP Status Code |  Reason
----             |  ------
200              |  Successful operation
201              |  Successful creation
204              |  Successful operation, there is no body to return
400              |  Missing required parameter
401              |  Not authorized or invalid token data
404              |  Patient or resource not found
409              |  Request has data conflict with server
422              |  Request data unprocessable
