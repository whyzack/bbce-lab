FROM python:3.9
WORKDIR /app
ADD . /app
RUN pip install redis

EXPOSE 8080
ENTRYPOINT ["python", "main.py"]
