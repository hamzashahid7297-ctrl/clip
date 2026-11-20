FROM python:3.11-slim
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg fonts-dejavu-core && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r backend/requirements-server.txt
ENV PYTHONUNBUFFERED=1
# Persist these with volumes: /app/input, /app/output, /app/state, /app/learnings, /root/.cache (Whisper model)
CMD ["sh", "-c", "uvicorn backend.server:app --host 0.0.0.0 --port ${PORT:-8000}"]
