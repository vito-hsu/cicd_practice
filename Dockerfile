# 使用官方的 Python 映像檔作為基礎映像檔
FROM python:3.9-slim-buster

# 設定工作目錄
WORKDIR /app

# 將 requirements.txt 複製到工作目錄中
# 先複製依賴文件以便利用 Docker 緩存
COPY requirements.txt .

# 安裝所有 Python 依賴
# 如果沒有 requirements.txt 檔案，可以移除這一步
RUN pip install --no-cache-dir -r requirements.txt

# 將專案的所有程式碼複製到工作目錄中
# 這會複製 app.py, test_app.py 等所有檔案
COPY . .

# 定義容器啟動時執行的命令
# 如果 app.py 是一個簡單的 Python 腳本，直接執行它即可
# 如果 app.py 是某個框架的入口 (例如 Flask 或 FastAPI)，則需要對應的啟動指令
CMD ["python", "app.py"]

# 注意：
# 如果您的 app.py 是一個 Web 應用程式 (例如 Flask, FastAPI)，它可能需要監聽一個端口。
# 在這種情況下，您可能需要 EXPOSE <port_number> 指令，例如 EXPOSE 5000。
# 並且 CMD 指令也會有所不同，例如：
# CMD ["flask", "run", "--host=0.0.0.0"]
# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
# 請根據您的 app.py 實際的啟動方式來調整 CMD 指令。
