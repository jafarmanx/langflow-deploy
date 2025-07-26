#!/bin/sh
set -x
echo "Setting PYTHONPATH..."
export PYTHONPATH=/app/src/backend/base
echo "PYTHONPATH is now: $PYTHONPATH"
echo "Starting backend..."
# Start uvicorn in the background
uvicorn src.backend.base.langflow.main:create_app --host 0.0.0.0 --port 8000 --log-level debug --factory &
UVICORN_PID=$!
echo "Uvicorn started with PID $UVICORN_PID"
# Start nginx
echo "Starting nginx..."
nginx -g "daemon off;" &
NGINX_PID=$!
echo "Nginx started with PID $NGINX_PID"
# Wait for either process to exit
wait