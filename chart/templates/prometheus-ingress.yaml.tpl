{{- if .Values.enabled }}{{- if .Values.prometheusIngress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: prometheus-ingress
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "2"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  entryPoints:
    - {{ .Values.prometheusIngress.entrypoint | default "websecure" | quote }}
  routes:
    - match: Host(`{{ .Values.prometheusIngress.ingressUrl }}`)
      kind: Rule
      {{- if .Values.prometheusIngress.middlewares }}
      middlewares:
        {{- range .Values.prometheusIngress.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: "{{ .Release.Name }}-prometheus-server"
          port: 80
  tls:
    secretName: grafana-tls
{{- end }}{{- end }}