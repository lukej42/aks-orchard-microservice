{{- define "orchard-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "orchard-chart.fullname" -}}
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

{{- define "orchard-chart.labels" -}}
helm.sh/chart: {{ include "orchard-chart.name" . }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "orchard-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "orchard-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "orchard-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "orchard-chart.connectionString" -}}
{{- if .Values.tenant.connectionString -}}
{{- .Values.tenant.connectionString -}}
{{- else if eq .Values.tenant.connectionStringRef "shared" -}}
{{- required "database.connectionString must be set in values.yaml when connectionStringRef is shared" .Values.database.connectionString -}}
{{- else -}}
{{- required "Set tenant.connectionStringRef to 'shared' or provide tenant.connectionString" .Values.database.connectionString -}}
{{- end -}}
{{- end }}
