FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN mkdir -p staticfiles
RUN python manage.py collectstatic --noinput

EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "course_project.course_project.wsgi:application"]