# Kong Plugin: Add the date in an HTTP header response

## How to deploy it
See [Deploy Plugins](https://docs.konghq.com/gateway/latest/plugin-development/get-started/deploy/) on docs.konghq.com

## How to use it
1) Create a GW Service
- Upstream URL=`http://httpbin.konghq.com`
2) Create a Route attached to the Service
- path=`/httpbin`
3) Add the `add-date-in-response` plugin to the Service
- you can change the default HTTP Header name, called: `X-My-Date`
4) Let's try it
- Request:
```shell
curl http://localhost:7000/httpbin/anything
```
- Response with the expected `X-My-Date`:
```
HTTP/1.1 200 OK
X-My-Date: Monday Mon Dec 16 16:02:45 2024
```
...
```json

{
    "args": {},
    "headers": {
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate",
        "...": "",
        "X-Kong-Request-Id": "445ac753c027e1458a18f4591c64df0c"
    },
    "url": "http://localhost/anything"
}