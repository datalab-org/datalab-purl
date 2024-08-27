.ONESHELL:
SHELL := /bin/sh
SHELLARGS := -e -pipefail -c
COMBINED_FILE := "./combined.yaml"

build-nginx-config:
	uv run src/build-nginx-configs.py
