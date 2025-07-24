
# Dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY . /app/
# Install system dependencies
RUN apt-get update && apt-get install -y gcc

# Copy requirements first for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Set environment variables
ENV PORT=80
EXPOSE 80

# Start Gunicorn server
CMD ["gunicorn", "--bind", "0.0.0.0:${PORT}", "--workers", "4", "app:app"]