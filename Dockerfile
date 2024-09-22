FROM python:3.10.4-slim-buster

# Update and install dependencies
RUN apt update && apt upgrade -y
RUN apt-get install -y git curl wget python3-pip ffmpeg software-properties-common neofetch bash

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip3 install wheel
RUN pip3 install --no-cache-dir -U -r requirements.txt

# Set working directory
WORKDIR /app
COPY . .

# Expose the port for the web service
EXPOSE 8000

# Start gunicorn to serve the app on port 8000, and start python script
CMD gunicorn --bind 0.0.0.0:8000 app:app && python3 -m devgagan
