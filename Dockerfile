# Cf. https://hub.docker.com/_/python/
FROM python:3.10.5-alpine3.16

LABEL maintainer "florian.stosse@safrangroup.com"
LABEL lastupdate "2022-04-18"
LABEL author "Florian Stosse"
LABEL description "UEFI-r2 v1.2.4, built using Python v3.10.4 Alpine-based image"
LABEL license "MIT license"

RUN addgroup -g 666 appuser && \
    mkdir -p /home/appuser && \
    adduser -D -h /home/appuser -u 666 -G appuser appuser && \
    chown -R appuser:appuser /home/appuser
ENV PATH="/home/appuser/.local/bin:${PATH}"
USER appuser

# Cf. https://pypi.org/project/uefi-r2/
RUN pip3 install --upgrade pip && \
    pip3 install --trusted-host files.pythonhosted.org uefi-r2==1.2.4 --user
