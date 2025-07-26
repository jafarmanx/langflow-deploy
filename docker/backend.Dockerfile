FROM python:3.11-slim
WORKDIR /app
COPY ../src/backend/base/pyproject.toml ../src/backend/base/uv.lock ../src/backend/base/README.md ./
RUN pip install uv
RUN uv pip install --system .
COPY ../src/backend ./src/backend
EXPOSE 8000
CMD ["uvicorn", "src.backend.base.langflow.main:create_app", "--host", "0.0.0.0", "--port", "8000", "--factory"] 