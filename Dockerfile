FROM python:3.11-slim

# Set working directory
WORKDIR /app

# 1. Copy ONLY requirements first
COPY . /app/
RUN pip install -r requirements.txt
CMD [ "python3", "app.py" ]