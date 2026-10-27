FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /build

COPY requirements.txt .
RUN python -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir -r requirements.txt


FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app \
    PATH="/opt/venv/bin:$PATH"

WORKDIR /app

RUN useradd --create-home --uid 10001 appuser \
    && chown appuser:appuser /app

COPY --from=builder /opt/venv /opt/venv
COPY --chown=appuser:appuser app ./app
RUN find /app/app -type f -exec chmod a-x {} +

USER appuser

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]


FROM runtime AS test

USER root

COPY requirements.txt requirements-dev.txt ./
RUN pip install --no-cache-dir -r requirements-dev.txt

COPY --chown=appuser:appuser tests ./tests
RUN find /app/tests -type f -exec chmod a-x {} +

USER appuser

CMD ["pytest", "-v"]


FROM runtime AS production