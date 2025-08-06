apiVersion: grafana.integreatly.org/v1beta1
kind: GrafanaDatasource
metadata:
  name: <data-source-name>
  namespace: <grafana-operator-namespace>
spec:
  instanceSelector:
    matchLabels:
      dashboards: <Grafana-cloud-stack-name>
  allowCrossNamespaceImport: true
  datasource:
    access: proxy
    database: prometheus
    jsonData:
      timeInterval: 5s
      tlsSkipVerify: true
    name: <data-source-name>
    type: prometheus
    url: <data-source-url>