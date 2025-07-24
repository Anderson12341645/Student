FROM python:3.11-slim

WORKDIR /app

# Copy only requirements first for caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your app
COPY . .

# Use dynamic port binding
CMD gunicorn --bind 0.0.0.0:$PORT --workers 4 app:app