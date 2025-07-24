FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Create temp directory with correct permissions
RUN mkdir -p /temp && chmod 777 /temp
ENV TMPDIR=/temp

# Copy requirements first for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Use port 8181
EXPOSE 8181

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8181", "--workers", "4", "app:app"]