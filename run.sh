#!/bin/bash
set -euo pipefail

bash install.sh

GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}FastAPI backend is running in Docker. You can now test the API endpoints.\n"${NC}
printf "${GREEN}Visit http://localhost:8000/docs to see the OpenAPI documentation.\n"${NC}
