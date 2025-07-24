FROM python:3.11-slim

# Set working directory
WORKDIR /app

# 1. Copy ONLY requirements first
COPY requirements.txt .

# 2. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 3. Copy the entire application
COPY . .

# Use port 80 for Azure
EXPOSE 80

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "--workers", "4", "app:app"]