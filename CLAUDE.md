# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

RAGFlow is an open-source RAG (Retrieval-Augmented Generation) engine based on deep document understanding. It combines LLM capabilities with advanced document processing and knowledge retrieval.

## Architecture

### Core Components

- **Frontend (web/)**: React-based UI using Umi framework, TypeScript, and Ant Design
- **Backend (api/)**: Flask-based REST API server
- **RAG Engine (rag/)**: Core retrieval and generation logic
- **Document Processing (deepdoc/)**: Advanced document parsing and understanding
- **Agent System (agent/)**: Workflow orchestration and AI agents
- **GraphRAG (graphrag/)**: Knowledge graph construction and querying
- **Plugins (plugin/)**: Extensible plugin system
- **MCP Support (mcp/)**: Model Context Protocol server and client

### Key Services

- **ragflow_server.py**: Main web server and API gateway
- **task_executor.py**: Background task processing
- **Document engines**: Elasticsearch (default), OpenSearch, or Infinity
- **Storage**: MinIO, AWS S3, Azure, or OSS
- **Database**: MySQL with Redis caching

## Development Setup

### Prerequisites
- Python 3.10-3.12
- Node.js >=18.20.4
- Docker & Docker Compose
- uv (Python package manager)

### Backend Development
```bash
# Install dependencies
uv sync --python 3.10 --all-extras
uv run download_deps.py

# Start dependencies
docker compose -f docker/docker-compose-base.yml up -d

# Add to /etc/hosts
127.0.0.1 es01 infinity mysql minio redis sandbox-executor-manager

# Launch backend
source .venv/bin/activate
export PYTHONPATH=$(pwd)
bash docker/launch_backend_service.sh
```

### Frontend Development
```bash
cd web
npm install
npm run dev
```

### Docker Development
```bash
# Full development environment
docker compose -f docker/docker-compose.yml up -d

# Check logs
docker logs -f ragflow-server
```

## Testing

### Python Tests
```bash
# Run pytest with coverage
pytest --no-cache --coverage

# Run specific test categories
pytest -m p1  # High priority tests
pytest -m p2  # Medium priority tests
pytest -m p3  # Low priority tests
```

### Frontend Tests
```bash
cd web
npm test
```

### Test Structure
- `test/`: Main test directory with HTTP API, SDK API, and Web API tests
- `sdk/python/test/`: SDK-specific tests
- Multiple test categories covering datasets, documents, chunks, chat assistants, and sessions

## Configuration

### Core Config Files
- `docker/service_conf.yaml.template`: Backend service configuration
- `docker/.env`: Environment variables for Docker setup
- `docker/docker-compose.yml`: Container orchestration
- `conf/service_conf.yaml`: Runtime service configuration

### Key Environment Variables
- `DOC_ENGINE`: Document storage engine (elasticsearch/opensearch/infinity)
- `STORAGE_IMPL`: Storage backend (MINIO/AWS_S3/AZURE_SAS/OSS)
- `HF_ENDPOINT`: HuggingFace model endpoint
- `PYTHONPATH`: Must be set to project root for development

## Code Quality

### Linting and Formatting
```bash
# Python linting
ruff check --fix

# Frontend linting
cd web && npm run lint
```

### Pre-commit Hooks
```bash
pre-commit install
```

## Key Development Notes

- Backend uses Flask with Peewee ORM for database operations
- Frontend uses Umi framework with TypeScript and Ant Design components
- Document processing leverages ONNX models for OCR and layout recognition
- Agent system supports complex workflows with multiple component types
- MCP server enables external tool integration
- Extensive plugin system for custom functionality

## Deployment

### Production Docker
```bash
# Build and deploy
docker compose -f docker/docker-compose.yml up -d

# Enable MCP server
docker compose -f docker/docker-compose.yml up -d --enable-mcpserver
```

### Development from Source
Follow the backend and frontend development setup, then ensure all services are running before testing.