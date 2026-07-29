# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.17@sha256:7e7266e344cd740e13a4145f0231b6f2aa070321f72f9b0264683519e7ac1e84

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources