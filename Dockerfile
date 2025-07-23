FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application
COPY . .

# Use port 80 for Azure
EXPOSE 80

# Start Gunicorn (ensure it's installed in requirements.txt)
CMD ["gunicorn", "--bind", "0.0.0.0:80", "--workers", "4", "app:app"]