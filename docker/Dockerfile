# --------- Frontend Build ---------
FROM node:20-alpine AS frontend-build
WORKDIR /app/frontend
COPY ../src/frontend/package*.json ./
RUN npm ci
COPY ../src/frontend/ ./
RUN npm run build

# --------- Backend Build ---------
FROM python:3.11-slim AS backend-build
WORKDIR /app
COPY ../src/backend/base/pyproject.toml ../src/backend/base/uv.lock ../src/backend/base/README.md ./
RUN pip install uv
RUN uv pip install --system .
# Install optional dependencies for additional components
COPY docker/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    # Clean up to reduce image size
    pip cache purge && \
    rm -rf /root/.cache/pip && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
COPY ../src/backend ./src/backend

# --------- Final Stage ---------
FROM python:3.11-slim
WORKDIR /app
# Install nginx and git (needed for git components)
RUN apt-get update && apt-get install -y nginx git && rm -rf /var/lib/apt/lists/*
# Copy Python dependencies and binaries
COPY --from=backend-build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=backend-build /usr/local/bin/uvicorn /usr/local/bin/uvicorn
COPY --from=backend-build /app/src/backend ./src/backend
COPY --from=frontend-build /app/frontend/build ./frontend/build
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 80 8000
CMD ["/start.sh"] 