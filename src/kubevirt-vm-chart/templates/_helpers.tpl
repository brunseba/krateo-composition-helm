{{/*
Expand the name of the chart.
*/}}
{{- define "kubevirt-vm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubevirt-vm.fullname" -}}
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
{{- define "kubevirt-vm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubevirt-vm.labels" -}}
helm.sh/chart: {{ include "kubevirt-vm.chart" . }}
{{ include "kubevirt-vm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
krateo.io/template: kubevirt-vm
{{- range $key, $value := .Values.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubevirt-vm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubevirt-vm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
VM Name
*/}}
{{- define "kubevirt-vm.vmName" -}}
{{- .Values.vm.name | default (include "kubevirt-vm.fullname" .) }}
{{- end }}

{{/*
Generate cloud-init user data
*/}}
{{- define "kubevirt-vm.cloudInitUserData" -}}
{{- if .Values.vm.cloudInit.enabled }}
{{- .Values.vm.cloudInit.userData | default "" }}
{{- else }}
#cloud-config
users:
  - name: {{ .Values.vm.os.distribution }}
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
{{- end }}
{{- end }}

{{/*
Generate OS image reference
*/}}
{{- define "kubevirt-vm.osImage" -}}
{{- $os := .Values.vm.os.type }}
{{- $dist := .Values.vm.os.distribution }}
{{- $version := .Values.vm.os.version }}
{{- if eq $os "linux" }}
{{- if eq $dist "ubuntu" }}
quay.io/kubevirt/cirros-container-disk-demo:{{ $version | default "latest" }}
{{- else if eq $dist "centos" }}
quay.io/kubevirt/centos-container-disk-demo:{{ $version | default "latest" }}
{{- else if eq $dist "fedora" }}
quay.io/kubevirt/fedora-container-disk-demo:{{ $version | default "latest" }}
{{- else }}
quay.io/kubevirt/cirros-container-disk-demo:latest
{{- end }}
{{- else }}
quay.io/kubevirt/windows-container-disk-demo:{{ $version | default "latest" }}
{{- end }}
{{- end }}

{{/*
Generate resource requirements
*/}}
{{- define "kubevirt-vm.resources" -}}
resources:
  requests:
    memory: {{ .Values.vm.resources.requests.memory | quote }}
    cpu: {{ .Values.vm.resources.requests.cpu | quote }}
  limits:
    memory: {{ .Values.vm.resources.limits.memory | quote }}
    cpu: {{ .Values.vm.resources.limits.cpu | quote }}
{{- end }}