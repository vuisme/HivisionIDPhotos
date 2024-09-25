FROM python:3.10-alpine

RUN apk add --no-cache \
    ffmpeg \
    mesa-gl \
    glib

WORKDIR /app


COPY requirements.txt requirements-app.txt ./

RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt

COPY . .

EXPOSE 7860
EXPOSE 8080

CMD ["python3", "-u", "app.py", "--host", "0.0.0.0", "--port", "7860"]
