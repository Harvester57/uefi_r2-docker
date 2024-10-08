# Cf. https://hub.docker.com/_/python/
FROM python:3.13.0-alpine3.20

LABEL maintainer "florian.stosse@gmail.com"
LABEL lastupdate "2024-09-15"
LABEL author "Florian Stosse"
LABEL description "FwHunt scanner v2.3.5, built using Python v3.12.6 Alpine-based image"
LABEL license "MIT license"

RUN apk add --no-cache -t .required_apks gcc make g++

RUN addgroup -g 666 appuser && \
    mkdir -p /home/appuser && \
    adduser -D -h /home/appuser -u 666 -G appuser appuser && \
    chown -R appuser:appuser /home/appuser
ENV PATH="/home/appuser/.local/bin:${PATH}"
USER appuser

# Cf. https://pypi.org/project/uefi-r2/
RUN pip3 install --upgrade pip && \
    pip3 install --trusted-host files.pythonhosted.org fwhunt-scan==2.3.5 --user

USER root
RUN apk del .required_apks
USER appuser
