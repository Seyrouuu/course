#!/bin/bash
set -o errexit

echo "Installing Python dependencies..."
pip install -r requirements.txt

echo "Running database migrations..."
python manage.py migrate

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Build completed successfully!"