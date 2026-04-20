# Cf. https://hub.docker.com/_/python/
FROM python:3.15.0a8-alpine@sha256:67a4b22b18852de8a9f668937641d2926e2dc9832b4a24ed29c9f5afb125251d

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
