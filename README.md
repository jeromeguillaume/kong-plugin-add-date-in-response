# Kong Plugin: Add the date in an HTTP header response

## How to deploy it
See [Deploy Plugins](https://docs.konghq.com/gateway/latest/plugin-development/get-started/deploy/) on docs.konghq.com

## How to use it with Self-managed Hybrid Kong Gateway
1) Create a GW Service
- Upstream URL=`http://httpbin.konghq.com`
2) Create a Route attached to the Service
- path=`/httpbin`
3) Add the `add-date-in-response` plugin to the Service
- you can change the default HTTP Header name, called: `X-My-Date`
4) Let's try it
- Request:
```shell
curl http://localhost:8000/httpbin/anything
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
```
## How to use it with Kubernetes Ingress Controller
See [kic](kic/) material for following steps
1) Control Plane: Push the `schema` by using the Konnect API
2) Data Plane: Create a Config Map for storing the `add-date-in-response` plugin
3) Data Plane: Add the `add-date-in-response` plugin to the `values.yaml` HELM:
```yaml
gateway:
  plugins:
    configMaps:
    - name: kong-plugin-add-date-in-response
      pluginName: add-date-in-response
```
Deploy the KIC including the plugin:
```shell
helm -n kong upgrade kong kong/ingress -f ./values.yaml
```
4) Data Plane: Create a Kubernetes `KongPlugin`
5) Data Plane: Add the `konghq.com/plugins: add-date-in-response` to your `Ingress` or `HTTPRoute` kinds
```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
 name: httpbin-route
 namespace: app
 annotations:
   konghq.com/strip-path: 'true'
   konghq.com/plugins: add-date-in-response
```