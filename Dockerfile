# Cf. https://hub.docker.com/_/python/
FROM python:3.15.0rc2-alpine@sha256:a73535961d3114b7b2e6948ef2dd8d295b885a76d3c23e87e688856713c1cbac AS builder

RUN apk add --no-cache gcc make g++ musl-dev

WORKDIR /app
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Cf. https://pypi.org/project/fwhunt-scan/
RUN pip install --no-cache-dir fwhunt-scan==2.3.8

FROM python:3.15.0rc2-alpine@sha256:a73535961d3114b7b2e6948ef2dd8d295b885a76d3c23e87e688856713c1cbac

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
