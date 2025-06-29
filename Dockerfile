# Cf. https://hub.docker.com/_/python/
FROM python:3.13-alpine@sha256:9b4929a72599b6c6389ece4ecbf415fd1355129f22bb92bb137eea098f05e975

LABEL maintainer="florian.stosse@gmail.com"
LABEL lastupdate="2025-06-22"
LABEL author="Florian Stosse"
LABEL description="FwHunt scanner v2.3.8, built using Python v3.13 Alpine-based image"
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
    pip3 install fwhunt-scan==2.3.8 --user --no-cache-dir

USER root
RUN apk del .required_apks
USER appuser
