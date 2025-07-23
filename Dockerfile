FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# 1️⃣ First, copy ONLY dependency files
COPY requirements.txt .
COPY setup.py .          # ⬅️ Add this (or pyproject.toml if you use it)
COPY pyproject.toml .    # ⬅️ Include if applicable

# 2️⃣ Install dependencies (now has context for local package)
RUN pip install -r requirements.txt

# 3️⃣ Now copy the rest of the application
COPY . .

# Use port 80 for Azure
EXPOSE 80

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "--workers", "4", "app:app"]