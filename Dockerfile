FROM python:3.10-alpine

# Cài đặt glibc cho Alpine
RUN apk --no-cache add \
    libstdc++ \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r0/glibc-2.35-r0.apk \
    && apk add glibc-2.35-r0.apk

# Cài đặt các gói hệ thống cần thiết
RUN apk add --no-cache \
    ffmpeg \
    mesa-gl \
    glib

WORKDIR /app

# Sao chép tệp yêu cầu
COPY requirements.txt requirements-app.txt ./

# Cài đặt các phụ thuộc Python
RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt

# Sao chép mã nguồn vào container
COPY . .

# Mở các cổng cần thiết
EXPOSE 7860
EXPOSE 8080

# Khởi chạy ứng dụng
CMD ["python3", "-u", "app.py", "--host", "0.0.0.0", "--port", "7860"]
