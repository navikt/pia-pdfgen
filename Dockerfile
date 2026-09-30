# Dockerfile
FROM ghcr.io/navikt/pdfgenrs:1.0.43@sha256:61b7bdcfe8f2b94bde98ca239ad0a80a57d7050a459751a5c938d8c0c74ba644

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources