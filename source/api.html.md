---
title: API Reference

language_tabs:
  - http

toc_footers:
  - <a href='https://app.netlify.com/applications'>Start a new application!</a>

includes:
  - rest_sites
  - rest_deploys
  - rest_submissions
  - rest_forms
  - rest_hooks
  - rest_files
  - rest_snippets
  - rest_metadata

search: true
---

# REST Reference

<aside class=warning>
All endpoints are SSL only.
</aside>
All URLs start with `https://api.netlify.com/api/v1/`. The path is prefixed with the API version. If we change the API in backward-incompatible ways, we'll bump the version marker and maintain stable support for the old URLs.

To make a request for all the sites you have access to, you'd append the sites' index path to the base url to form something like https://api.netlify.com/api/v1/sites. In curl, that looks like:

``` shell
curl -H 'User-Agent: MyApp (yourname@example.com)' \
     -H 'Authorization: Bearer {:auth_token}'      \
     https://api.netlify.com/api/v1/sites
```

<aside>
On error the endpoint will send back an appropriate HTTP response and a useful JSON payload.
</aside>

## Rate Limiting

To protect Netlify from getting flooded by automated deploys or misbehaving applications, the Netlify API is rate limited.

You can make up to **200 requests per minute**.

The HTTP headers of any API request has the current rate limit status:

``` http
GET /api/v1/sites HTTP/1.1
X-RateLimit-Limit: 200
X-RateLimit-Remaining: 56
X-RateLimit-Reset: 1372700873
```

If you need higher limits, please [contact us](TODO).

## Pagination

Requests that return multiple items will be paginated to 100 items by default. You can specify further pages with a combination of the `page` and `per_page` query parameters. They are assumed to be consistent between calls, meaning
`?page=3&per_page=10` would get you back entries from 30 - 39.

Parameter | Default | Description
----------|---------|------------
per_page | 100 | the size of a page, assumed to be consistent between paged calls
page | 1 | which page to retrieve

<aside class=notice>
note: page numbering is 1-based and that omitting the <code>page</code> query parameter will return the first page.
</aside>

### Link Header

The pagination info is included in the `Link` header.

``` http
GET /api/v1/sites?page=3&per_page=20 HTTP/1.1

Link: <https://api.netlify.com/api/v1/sites?page=3&per_page=20>; rel="next", \
      <https://api.netlify.com/api/v1/sites?page=5&per_page=20>; rel="last"
```

The possible `rel` values are:

* `next`
  Shows the URL of the immediate next page of results.
* `last`
  Shows the URL of the last page of results.
* `prev`
  Shows the URL of the immediate previous page of results.

## Nested Endpoints
Many of the endpoints are nestable. The governing principle is that once you have a id of a resource (e.g. site, deploy) you can directly access the resource.

For instance, you can access the same resource by through either of these endpoints:

- `/deploys/{:deploy_id}`
- `/sites/{:site_id}/deploys/{:deploy_id}`

You can also use the path to a collection as a filter. All the forms available for a key are at `/forms`. Those can then be filtered down by to those of a single site through `/sites/{:site_id}/forms`.
