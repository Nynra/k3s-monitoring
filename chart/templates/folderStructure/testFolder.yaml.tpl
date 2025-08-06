apiVersion: grafana.integreatly.org/v1beta1
kind: GrafanaDashboard
metadata:
  name: <folder-name>
  namespace: <grafana-operator-namespace>
spec:
  instanceSelector:
    matchLabels:
      dashboards: <Grafana-cloud-stack-name>
  folder: "<folder-name>"
  json: >
  {
    "title": "as-code dashboard",
    “uid” : “ascode”
  }