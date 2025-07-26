FROM python:3.11-slim
WORKDIR /app

# Copy base package files
COPY ../src/backend/base/pyproject.toml ../src/backend/base/uv.lock ../src/backend/base/README.md ./

# Install uv
RUN pip install uv

# Install base package
RUN uv pip install --system .

# Install optional dependencies for additional components
COPY docker/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && \
    # Clean up to reduce image size
    pip cache purge && \
    rm -rf /root/.cache/pip && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

# Copy backend source
COPY ../src/backend ./src/backend

EXPOSE 8000
CMD ["uvicorn", "src.backend.base.langflow.main:create_app", "--host", "0.0.0.0", "--port", "8000", "--factory"] 