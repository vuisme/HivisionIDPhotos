# Sử dụng python:3.10-slim thay vì alpine
FROM python:3.10-slim

# Cài đặt các gói hệ thống cần thiết
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Sao chép tệp yêu cầu
COPY requirements.txt requirements-app.txt ./

# Cài đặt các phụ thuộc Python, loại bỏ cache để giảm kích thước image
RUN pip install --no-cache-dir -r requirements.txt -r requirements-app.txt

# Sao chép mã nguồn vào container
COPY . .

# Mở các cổng cần thiết
EXPOSE 7860
EXPOSE 8080

# Khởi chạy ứng dụng
CMD ["python3", "-u", "app.py", "--host", "0.0.0.0", "--port", "7860"]
