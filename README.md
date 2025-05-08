# LiteLLM Customization Toolkit

A reference project showing how to extend and deploy a customized LiteLLM gateway with Docker Compose and PostgreSQL.

## Features

- **Docker Compose orchestration**  
  Brings up the LiteLLM gateway alongside a PostgreSQL database in one command.
- **Customizable Dockerfile**  
  Demonstrates how to inject your own code and configuration over the base LiteLLM image.
- **Proxy override example**  
  Includes an example of overriding the built-in proxy CLI within the LiteLLM package.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) ≥ 20.10
- [Docker Compose](https://docs.docker.com/compose/intro/) ≥ 1.29
- (Optional) [Make](https://www.gnu.org/software/make/) for helper commands

## Project Structure

```
.
├── config/
│   └── config.yaml            # LiteLLM configuration
├── docker-compose.yml         # Service definitions
├── Dockerfile                 # Base image and customization steps
├── override/
│   └── proxy/
│       └── proxy_cli.py       # Example override for proxy CLI
├── requirements.txt           # Pinned Python dependencies
└── README.md                  # This file
```

## Getting Started

1. **Build and start the services**
   ```bash
   docker compose up -d --build
   ```

2. **Check logs**
   ```bash
   docker compose logs -f litellm
   ```

3. **Open the API**  
   By default, LiteLLM listens on port 4000.
   ```
   http://localhost:4000/healthz
   ```

## Customization

- **Adding dependencies**  
  Update `requirements.txt` and rebuild:
  ```bash
  docker compose up -d --build litellm
  ```

- **Overriding code**  
  Any files you place under `override/` (e.g. `override/proxy/proxy_cli.py`) will replace the originals in the LiteLLM package.
