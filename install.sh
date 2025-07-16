#!/bin/bash
set -euo pipefail

GREEN='\033[0;32m'
NC='\033[0m'

if ! command -v docker > /dev/null; then
  echo 'Error: Docker is not installed or not in PATH.'
  exit 1
fi

if ! command -v docker-compose > /dev/null; then
  echo 'Error: docker-compose is not installed.'
  exit 1
fi

printf "${GREEN}Building Docker images...${NC}\n"
docker-compose build

printf "${GREEN}Starting Docker containers...${NC}\n"
docker-compose up -d

printf "${GREEN}Waiting for FastAPI to start...${NC}\n"

max_retries=15
count=0
until curl -s http://localhost:8000/ >/dev/null; do
  sleep 1
  ((count++))
  if [ $count -ge $max_retries ]; then
    echo 'FastAPI server did not respond in time.'
    exit 1
  fi
done

printf "${GREEN}FastAPI service is up and running!${NC}\n"
