# Cf. https://hub.docker.com/_/python/
FROM python:3.10.4-alpine3.15

LABEL maintainer "florian.stosse@safrangroup.com"
LABEL lastupdate "2022-04-08"
LABEL author "Florian Stosse"
LABEL description "UEFI-r2, built using Python v3.10.4 Alpine-based image"
LABEL license "MIT license"

# Cf. https://pypi.org/project/uefi-r2/
RUN pip3 install --trusted-host files.pythonhosted.org uefi-r2==1.2.3