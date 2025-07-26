# Docker Optimization Guide

## Disk Space Issues

The Docker build is failing due to insufficient disk space when copying Python packages. This is a common issue when installing many dependencies.

## Solutions

### 1. Clean Up Docker System

First, clean up your Docker system to free up space:

```bash
# Remove unused containers, networks, images
docker system prune -a

# Remove all unused volumes
docker volume prune

# Remove all unused images
docker image prune -a
```

### 2. Increase Docker Disk Space

If you're using Docker Desktop:

1. Open Docker Desktop
2. Go to Settings/Preferences
3. Navigate to Resources → Advanced
4. Increase the disk image size (recommend at least 50GB)
5. Apply & Restart

### 3. Use Build Cache Efficiently

The optimized Dockerfile now includes:
- `--no-cache-dir` flag to prevent pip from caching packages
- Cleanup commands to remove temporary files
- Requirements file for better organization

### 4. Alternative: Build in Stages

If you're still having issues, you can build the image in stages:

```bash
# Build backend stage only
docker build --target backend-build -t langflow-backend .

# Then build the full image
docker build -t langflow-full .
```

### 5. Use Docker BuildKit

Enable BuildKit for better performance:

```bash
export DOCKER_BUILDKIT=1
docker-compose build
```

### 6. Monitor Disk Usage

Check your disk space:

```bash
# On macOS/Linux
df -h

# Check Docker disk usage
docker system df
```

### 7. Alternative: Use .dockerignore

Create a `.dockerignore` file to exclude unnecessary files:

```
.git
.gitignore
README.md
*.md
tests/
docs/
```

### 8. Build with Memory Limits

If you have limited RAM, you can limit Docker's memory usage:

```bash
docker-compose build --memory=4g
```

## Optimized Dockerfile Features

The updated Dockerfile includes:

1. **Requirements File**: All dependencies are now in `docker/requirements.txt` for better organization
2. **No Cache**: Uses `--no-cache-dir` to prevent pip from storing packages
3. **Cleanup**: Removes temporary files and caches after installation
4. **Multi-stage**: Efficiently copies only necessary files between stages

## Expected Results

After implementing these optimizations:

- Reduced image size through cleanup
- Better build performance with BuildKit
- More organized dependency management
- Easier maintenance with requirements file

## Troubleshooting

If you still encounter issues:

1. **Check available disk space**: Ensure you have at least 10GB free
2. **Restart Docker**: Sometimes Docker needs a restart after configuration changes
3. **Use external storage**: Consider moving Docker data to an external drive
4. **Build on cloud**: Use a cloud service like GitHub Actions for building large images

## Next Steps

1. Clean up Docker system
2. Increase Docker disk space if needed
3. Try building with the optimized Dockerfile
4. Monitor the build process for any remaining issues 