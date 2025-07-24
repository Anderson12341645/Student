FROM python:3.11-slim

WORKDIR /app
COPY . /app/

# Copy requirements first for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY . .

# Use fixed port 80
EXPOSE 80

# Start Gunicorn with fixed port
CMD ["gunicorn", "--bind", "0.0.0.0:80", "--workers", "4", "app:app"]