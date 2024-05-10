#!/bin/bash

# Create the project directory
mkdir recs-armory
cd recs-armory

# Create the .github/workflows directory and the docker-build.yml file
mkdir -p .github/workflows
cat > .github/workflows/docker-build.yml <<EOL
name: Docker Build

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1
      with:
        driver-opts: |
          cloud=dagz55/recs-build001

    - name: Login to Docker Hub
      uses: docker/login-action@v1
      with:
        username: \${{ secrets.DOCKER_USERNAME }}
        password: \${{ secrets.DOCKER_PASSWORD }}

    - name: Build and push Docker image
      uses: docker/build-push-action@v2
      with:
        context: .
        push: true
        tags: user/app:latest
EOL

# Create the src directory and a sample app.py file
mkdir src
cat > src/app.py <<EOL
print("Hello, World!")
EOL

# Create the tests directory
mkdir tests

# Create the Dockerfile
cat > Dockerfile <<EOL
FROM python:3.9-slim

WORKDIR /app

COPY src/ /app/

CMD ["python", "app.py"]
EOL

# Create the .gitignore file
cat > .gitignore <<EOL
# Ignore build artifacts
build/
dist/

# Ignore Python cache files
__pycache__/
*.pyc

# Ignore environment files
.env
venv/
EOL

# Create the README.md file
cat > README.md <<EOL
# Your Project

This is a sample project structure.

## Building the Docker Image

To build the Docker image, run the following command:

\`\`\`
docker build -t recs-armory-image .
\`\`\`

## Running the Application

To run the application, use the following command:

\`\`\`
docker run --rm recs-armory-image
\`\`\`
EOL

echo "Project structure created successfully!"
