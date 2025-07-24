FROM python:3.11-slim

# Set working directory
WORKDIR /app

# 1. Copy ONLY requirements first
COPY . /app/
RUN pip install -r requirements.txt
CMD ["--bind", "0.0.0.0:8181", "--workers", "4", "app:app"]