FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    postgresql-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project
COPY . .

# Create staticfiles directory and collect static files
RUN mkdir -p staticfiles
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 10000

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "course_project.wsgi:application"]