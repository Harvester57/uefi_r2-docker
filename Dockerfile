# Cf. https://hub.docker.com/_/python/
FROM python:3.13.3-alpine3.21@sha256:452682e4648deafe431ad2f2391d726d7c52f0ff291be8bd4074b10379bb89ff

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-05-19"
LABEL author="Florian Stosse"
LABEL description="FwHunt scanner v2.3.8, built using Python v3.13.3 Alpine-based image"
LABEL license="MIT license"

RUN apk update && \
    apk upgrade --available

RUN apk add --no-cache -t .required_apks gcc make g++ ca-certificates

RUN addgroup -g 666 appuser && \
    mkdir -p /home/appuser && \
    adduser -D -h /home/appuser -u 666 -G appuser appuser && \
    chown -R appuser:appuser /home/appuser
ENV PATH="/home/appuser/.local/bin:${PATH}"
USER appuser

# Cf. https://pypi.org/project/fwhunt-scan/
RUN pip3 install --upgrade pip && \
    pip3 install fwhunt-scan==2.3.8 --user

USER root
RUN apk del .required_apks
USER appuser
