# --- builder stage ---
FROM python:3.13-slim AS builder
WORKDIR /app

# Install build-time deps only
RUN apt-get update \
 && apt-get install -y --no-install-recommends gcc \
 && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies into user site
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --user --no-cache-dir -r requirements.txt

# final stage
FROM python:3.13-slim
WORKDIR /app

# Create app user
RUN useradd --create-home --home-dir /home/app appuser \
 && mkdir -p /home/app/.local \
 && chown -R appuser:appuser /home/app

ENV PATH=/home/app/.local/bin:$PATH \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

# Copy from builder into the new home
COPY --chown=appuser:appuser --from=builder /root/.local /home/app/.local
COPY --chown=appuser:appuser override/proxy/proxy_cli.py \
     /home/app/.local/lib/python3.13/site-packages/litellm/proxy/proxy_cli.py
COPY --chown=appuser:appuser openai_openapi.yaml /app/openai_openapi.yaml

COPY config/config.yaml /app/config/

EXPOSE 4000
USER appuser

CMD ["litellm", "--config", "/app/config/config.yaml", "--host", "0.0.0.0", "--port", "4000"]
