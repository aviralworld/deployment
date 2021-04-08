{{/*
Expand the name of the chart.
*/}}
{{- define "aviralworld.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "aviralworld.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "aviralworld.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "aviralworld.labels" -}}
helm.sh/chart: {{ include "aviralworld.chart" . }}
{{ include "aviralworld.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "aviralworld.selectorLabels" -}}
app.kubernetes.io/name: {{ include "aviralworld.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "aviralworld.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "aviralworld.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common New Relic configuration
*/}}
{{- define "aviralworld.newrelic" -}}
- name: NEW_RELIC_NO_CONFIG_FILE
  value: "1"
- name: NEW_RELIC_APP_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.newRelic.secretRef }}
      key: APP_NAME
- name: NEW_RELIC_LICENSE_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.newRelic.secretRef }}
      key: LICENSE_KEY
{{- end }}
