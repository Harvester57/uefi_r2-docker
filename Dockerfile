# Cf. https://hub.docker.com/_/python/
FROM python:3.15.0rc3-alpine@sha256:f288a00331ddad8ddf86aa9d83331f188d9a5b1999dea3762adf2af1968b0c04 AS builder

RUN apk add --no-cache gcc make g++ musl-dev

WORKDIR /app
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Cf. https://pypi.org/project/fwhunt-scan/
RUN pip install --no-cache-dir fwhunt-scan==2.3.8

FROM python:3.15.0rc3-alpine@sha256:f288a00331ddad8ddf86aa9d83331f188d9a5b1999dea3762adf2af1968b0c04

LABEL org.opencontainers.image.authors="Florian Stosse <florian.stosse@gmail.com>"
LABEL org.opencontainers.image.created="2025-06-22"
LABEL org.opencontainers.image.description="FwHunt scanner v2.3.8, built using Python Alpine-based image"
LABEL org.opencontainers.image.licenses="MIT license"

RUN apk add --no-cache libstdc++ && \
    addgroup -g 666 appuser && \
    adduser -D -h /home/appuser -u 666 -G appuser appuser

COPY --from=builder /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

USER appuser

ENTRYPOINT [ "fwhunt_scan_analyzer.py" ]
