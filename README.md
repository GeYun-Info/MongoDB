# MongoDB Docker 運行環境

此目錄包含使用 Docker Compose 啟動並管理 MongoDB 的設定檔與捷徑腳本。

## 前置作業

1. **建立外部網路**：
   在啟動容器前，請先確保名為 `shared-net` 的外部 Docker 網路已經建立：
   ```bash
   docker network create shared-net
   ```

2. **設定環境變數**：
   此專案使用環境變數來管理敏感資訊與 Port 設定。請先複製範本檔案並命名為 `.env`：
   ```bash
   cp .env.sample .env
   ```
   然後打開 `.env` 檔案，修改您的連線 Port、帳號及密碼設定。*(注意：`.env` 檔案已被列入 `.gitignore`，不會被提交上 Git。)*

## 容器設定說明

*   **容器名稱**：`mongo_db`
*   **映像檔版本**：`mongo:latest`
*   **對外 Port 埠號**：讀取自 `.env` 中的 `MONGO_PORT`（預設為 `27017`）
*   **管理員帳號**：讀取自 `.env` 中的 `MONGO_INITDB_ROOT_USERNAME`（預設為 `root`）
*   **管理員密碼**：讀取自 `.env` 中的 `MONGO_INITDB_ROOT_PASSWORD`
*   **網路模式**：連接外部網路 `shared-net`

### 掛載路徑 (Volumes)

*   `./mongo-data`：資料庫實體檔案的持久化儲存區。*(此資料夾的結構會被 Git 追蹤，但其內部的資料庫檔案會被自動忽略)*
*   `./mongod.conf`：MongoDB 的設定檔。

## 容器管理指令

您可以使用目錄下提供的 Windows 批次檔 `run.bat` 或 Linux/macOS 腳本 `run.sh` 來輕鬆管理容器。

### 支援的指令

*   `build`   - 重新建置映像檔（不使用快取）。
*   `up`      - 在背景啟動 MongoDB 容器。
*   `down`    - 停止並移除 MongoDB 容器。
*   `start`   - 啟動已停止的容器。
*   `stop`    - 停止運行中的容器。
*   `logs`    - 即時查看容器日誌 (Tails logs)。
*   `restart` - 重新啟動容器。

### 使用範例 (Windows)
```cmd
.\run.bat
輸入指令: up
```

### 使用範例 (Linux/macOS)
```bash
./run.sh
輸入指令: logs
```

## 資料庫連線字串 (Connection String)

### 1. 從本機 (Host) 連線
如果您要使用 MongoDB Compass 或其他本機 GUI 工具連線，連線字串格式如下：
```
mongodb://<帳號>:<編碼後的密碼>@localhost:<PORT>/
```
*例如，使用預設範本設定連線：*
```
mongodb://root:38b%2043a%3B%20dw54@localhost:27017/
```
*(💡 **重要提示**：如果您的密碼包含空白、分號或其他特殊字元，在連線字串中必須進行 **URL 編碼**。例如密碼為 `38b 43a; dw54` 時，需轉換為 `38b%2043a%3B%20dw54`。)*

### 2. 從同一個 `shared-net` 網路中的其他 Docker 容器連線
如果是內部 Docker 容器要互相連線，請使用容器服務名稱 `mongo`：
```
mongodb://root:38b%2043a%3B%20dw54@mongo:27017/
```
