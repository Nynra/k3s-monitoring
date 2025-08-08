{{- if .Values.enabled }}{{- if .Values.grafanaIngress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: grafana-ingress
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
    - {{ .Values.grafanaIngress.entrypoint | default "websecure" | quote }}
  routes:
    - match: Host(`{{ .Values.grafanaIngress.ingressUrl }}`)
      kind: Rule
      {{- if .Values.grafanaIngress.middlewares }}
      middlewares:
        {{- range .Values.grafanaIngress.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: "{{ .Release.Name }}-grafana"
          port: 80
          # sticky:
          #   cookie:
          #     httpOnly: true
          #     name: grafana
          #     secure: true
          #     sameSite: none
  tls:
    secretName: {{ .Values.grafanaIngress.certName | quote }}
{{- end }}{{- end }}