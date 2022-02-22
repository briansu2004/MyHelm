{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "helm-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "helm-chart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "helm-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Define TELUS Labels */}}
{{- define "telus.labels" -}}
telus.cmbdId: {{ .Values.telus.cmdbId | toString | trunc 63 | quote }}
telus.costCentre: {{ .Values.telus.costCentre | trunc 63 | quote}}
telus.organization: {{ .Values.telus.organization | trunc 63 | quote}}
environment: {{ .Values.environment | trunc 63 | quote}}
{{- end }}}}
{{/* Define TELUS Annotations */}}
{{- define "telus.annotations" -}}
generator: "helm"
#Can't use timezone notations because + is not valid in a configmap
helm.sh/chart: {{ include "helm-chart.chart" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name  | trunc 63 | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | trunc 63 | quote }}
app.kubernetes.io/release-revision: {{ .Release.Revision | toString | trunc 63 | quote }}
generatedDate: {{ date "2006-01-02T15:04:05Z07:00" (now) | quote }}
telus.cmbdId: {{ .Values.telus.cmdbId | toString | trunc 63 | quote }}
telus.costCentre: {{ .Values.telus.costCentre | trunc 63 | quote }}
telus.organization: {{ .Values.telus.organization | trunc 63 | quote}}
telus.mailingList: {{ .Values.telus.mailingList | quote}}
{{- end }}}}