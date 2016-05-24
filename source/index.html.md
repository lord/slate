---
title: API Reference

language_tabs:
  - Javascript

toc_footers:
  - <a href='/'>Made by hand in Finland</a>
 
includes:
  - api
  - callbacks
  - enums
  - auth
  - integrate
  - require
  - init
  - support

search: true
---

# Introduction

Welcome to the _callstats.io_ API! 

The callstats.io's Javascript client library enables performance monitoring features in browser-based WebRTC endpoints. The communication with callstats.io occurs over _Secure HTTP_ (`https://`) and _Secure WebSocket_ (`wss://`). The endpoint (the browser in this case) MUST support [WebSockets](https://www.w3.org/TR/websockets/). Additionally, the origin server MUST allow _Cross-Origin Resource Sharing_ ([CORS](http://enable-cors.org/server.html)) and MAY need to serve its own pages over HTTPS to avoid mixed content warnings.


## Versioning

`callstats.js` uses [semantic versioning](http://semver.org). The latest version is in the changelog.(TODO)



