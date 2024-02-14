FROM python:3.10
WORKDIR /app
COPY requirements.txt .
RUN apt update && apt install -y gcc python3-dev libpq-dev
RUN pip install "cython<3.0.0" && pip install --no-build-isolation pyyaml~=5.4
RUN pip install -r requirements.txt
COPY . .
RUN python manage.py migrate
EXPOSE 8000
CMD ["gunicorn", "tutorial.wsgi", "--bind", "0.0.0.0:8000", "--log-file", "-"]
