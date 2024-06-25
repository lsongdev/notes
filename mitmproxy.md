---
layout: default
title: mitmproxy
---

# mitmproxy

mitmproxy is a network proxy for testing and debugging HTTP and HTTPS traffic.

## Getting stared

### Usage

| Option | Example                                                                     | Description                               |
| ------ | --------------------------------------------------------------------------- | ----------------------------------------- |
| `-p`   | mitmproxy -p 8001                                                           | Start proxy on port 8001                  |
| `-m`   | mitmproxy -p 8001 -m reverse:[http://127.0.0.1:4000](http://127.0.0.1:4000) | Reverse proxy on port 8001 to port 4000   |
| `-w`   | mitmproxy -p 8001 -w traffic.mitm                                           | Stream flows to file as they arrive       |
| `-r`   | mitmproxy -r traffic.mitm                                                   | Read flows from file                      |
| `-C`   | mitmproxy -C traffic.mitm                                                   | Replay client requests from a saved file  |
| `-S`   | mitmproxy -S traffic.mitm                                                   | Replay server responses from a saved file |
| `-s`   | mitmproxy -s myScript.py                                                    | Execute a script                          |
| `-h`   | mitmproxy -h                                                                | mitmproxy quick help                      |

### Movement

```
        k                 Ctrl b
        ▲                   ▲▲
        │                   ││
h ◀ ─── + ─── ▶ l           ││ page
        │                   ││
        ▼                   ▼▼
        j             Ctrl f / Space
```

| -                    | -                     |
| -------------------- | --------------------- |
| `h`, `j`, `k` ,`l`   | Left, Down, Up, Right |
| `Ctrl` `b`           | Page up               |
| `Space` / `Ctrl` `f` | Page down             |
| `g` / `G`            | Go to beginning / end |
| `Arrows`             | Up, Down, Left, Right |



### Common Keybindings

| -       | -                |
| ------- | ---------------- |
| `q`     | Back / Exit      |
| `z`     | Clear flow list  |
| `:`     | Command prompt   |
| `E`     | View event log   |
| `O`     | View options     |
| `r`     | Replay this flow |
| `Tab`   | Next             |
| `Enter` | Select           |



### Global Keybindings

| -              | -                         |
| -------------- | ------------------------- |
| `-`            | Cycle to next layout      |
| `?`            | View help                 |
| `B`            | Start an attached browser |
| `C`            | View commands             |
| `I`            | Toggle intercept          |
| `K`            | View key bindings         |
| `P`            | View flow details         |
| `Q`            | Exit immediately          |
| `W`            | Stream to file            |
| `i`            | Set intercept             |
| `Ctrl` `right` | Focus next layout pane    |
| `Shift` `tab`  | Focus next layout pane    |



### Flow (View)

| -          | -                            |                           |
| ---------- | ---------------------------- | ------------------------- |
| `A`        | Resume all intercepted flows |                           |
| `D`        | Duplicate flow               |                           |
| `F`        | Set focus follow             |                           |
| `L`        | Load flows from file         |                           |
| `M`        | Toggle viewing marked flows  |                           |
| `S`        | Start server replay          |                           |
| `U`        | Un-set all marks             |                           |
| `V`        | Revert changes to this flow  |                           |
| `X`        | Kill this flow               |                           |
| `Z`        | Purge all flows not showing  |                           |
| `a`        | Resume this intercepted flow |                           |
| `b`        | Save response body to file   |                           |
| `d`        | Delete flow from view        |                           |
| `e`        | Export this flow to file     |                           |
| `f`        | Set view filter              |                           |
| `m`        | Toggle mark on this flow     |                           |
| `n`        | Create a new flow            |                           |
| `o`        | Set flow list order          |                           |
| `r`        | Replay this flow             |                           |
| `v`        | Reverse flow list order      |                           |
| `w`        | Save listed flows to file    |                           |
| \`         | \`                           | Run a script on this flow |
| `Ctrl` `l` | Send cuts to clipboard       |                           |



## Filter 

### Filter

| -   | -                                     |
| --- | ------------------------------------- |
| `f` | Set view filter _(on flow view page)_ |



* [RegEX cheatsheet](./regex) 

The regex are Python-style, it can be specified as quoted strings

### Operators

| -       | -         |    |
| ------- | --------- | -- |
| `!`     | unary not |    |
| `&`     | and       |    |
| \`      | \`        | or |
| `(...)` | grouping  |    |

### Expressions 

| -              | -                                                          |
| -------------- | ---------------------------------------------------------- |
| `~a`           | Match asset in response: CSS, Javascript, Flash, images.   |
| `~b` `regex`   | Body                                                       |
| `~bq` `regex`  | Request body                                               |
| `~bs` `regex`  | Response body                                              |
| `~c` `int`     | HTTP response code                                         |
| `~d` `regex`   | Domain                                                     |
| `~dst` `regex` | Match destination address                                  |
| `~e`           | Match error                                                |
| `~h` `regex`   | Header                                                     |
| `~hq` `regex`  | Request header                                             |
| `~hs` `regex`  | Response header                                            |
| `~http`        | Match HTTP flows                                           |
| `~m` `regex`   | Method                                                     |
| `~marked`      | Match marked flows                                         |
| `~q`           | Match request with no response                             |
| `~s`           | Match response                                             |
| `~src` `regex` | Match source address                                       |
| `~t` `regex`   | Content-type header                                        |
| `~tcp`         | Match TCP flows                                            |
| `~tq` `regex`  | Request Content-Type header                                |
| `~ts` `regex`  | Response Content-Type header                               |
| `~u` `regex`   | URL                                                        |
| `~websocket`   | Match WebSocket flows (and HTTP-WebSocket handshake flows) |

### Flow selectors

Expressions

| -           | -                          |
| ----------- | -------------------------- |
| `@all`      | All flows                  |
| `@focus`    | The currently focused flow |
| `@shown`    | All flows currently shown  |
| `@hidden`   | All flows currently hidden |
| `@marked`   | All marked flows           |
| `@unmarked` | All unmarked flows         |

mitmproxy has a set of convenient flow selectors that operate on the current view

### Examples

URL containing "google.com"

```
google\.com
```

Requests whose body contains the string "test"

```
~q ~b test
```

Anything but requests with a text/html content type:

```
!(~q & ~t "text/html")
```

Replace entire GET string in a request (quotes required to make it work):

```
":~q ~m GET:.*:/replacement.html"
```

## Scripts

### Custom response

```python
from mitmproxy import http


def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_url == "http://example.com/path":
        flow.response = http.HTTPResponse.make(
            200,  # (optional) status code
            b"Hello World",  # (optional) content
            {"Content-Type": "text/html"}  # (optional) headers
        )
```

Send a reply from the proxy without sending any data to the remote server

### Add header

```python
class AddHeader:
    def __init__(self):
        self.num = 0

    def response(self, flow):
        self.num = self.num + 1
        flow.response.headers["count"] = str(self.num)


addons = [
    AddHeader()
]
```

Add an HTTP header to each response

## See also

* [mitmproxy addons](https://github.com/mitmproxy/mitmproxy/tree/master/examples/addons) _(github.com)_
* [mitmproxy docs](https://docs.mitmproxy.org/) _(mitmproxy.org)_
