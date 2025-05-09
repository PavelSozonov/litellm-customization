# LiteLLM Customization Toolkit

A reference project showing how to extend and deploy a customized LiteLLM gateway with Docker Compose and PostgreSQL.

# LiteLLM Proxy + OpenAI Spec Integration

A reference project that extends the LiteLLM proxy by merging it with the official OpenAI API 2.0.0 OpenAPI spec, cleaning out unwanted fields, and unifying authentication under a single `x-litellm-api-key` header.

## Why these modifications?

- **Merge OpenAI routes**  
  Combine LiteLLM’s existing `/chat/completions`, `/embeddings`, etc., with the full OpenAI spec so your proxy supports every OpenAI-compatible endpoint out of the box.

- **Clean the spec**  
  Strip out extraneous `"user"` fields and OpenAI’s proprietary `x-oaiMeta` extensions, keeping only the parts you need and ensuring your documentation stays focused.

- **Custom API metadata**  
  Override the default title and description in Swagger UI with a branded message and links to your LiteLLM admin panel and model cost map.

- **Unified authentication**  
  Remove duplicated “Bearer token” schemes and enforce a single `APIKeyHeader` (`x-litellm-api-key`) for all operations. Swagger UI will show one lock icon and automatically inject your API key header.

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

## Getting Started

1. **Place your OpenAI spec**  
   Download or maintain `openai_openapi.yaml` in the project root.

2. **Build & run**
   ```bash
   docker compose up -d --build

3. **View Swagger UI**
   Open http://localhost:4000/docs and authorize with your x-litellm-api-key.

4. **Call any endpoint**
   All merged OpenAI and LiteLLM routes now appear in one unified API.

## How It Works

In override/proxy_cli.py, the custom_openapi() function:

1. Loads your base LiteLLM schema via get_openapi().

2. Injects a custom title & description.

3. Reads /app/openai_openapi.yaml, falls back from YAML to JSON.

4. Recursively strips "user" and x-oaiMeta fields.

5. Merges all OpenAI paths and components.

6. Defines a single APIKeyHeader security scheme (x-litellm-api-key) and applies it globally.

FastAPI then serves the combined schema at /openapi.json and renders it in Swagger UI at /docs.

