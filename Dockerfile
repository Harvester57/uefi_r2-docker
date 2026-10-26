# Cf. https://hub.docker.com/_/python/
FROM python:3.16.0a1-alpine@sha256:53bdba10dcf8ada33490e83add833c0a31e74c71423ee0396f2e4f0de01b6148 AS builder

RUN apk add --no-cache gcc make g++ musl-dev

WORKDIR /app
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Cf. https://pypi.org/project/fwhunt-scan/
RUN pip install --no-cache-dir fwhunt-scan==2.3.8

FROM python:3.16.0a1-alpine@sha256:53bdba10dcf8ada33490e83add833c0a31e74c71423ee0396f2e4f0de01b6148

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
