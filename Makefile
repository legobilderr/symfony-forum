#!/usr/bin/make
include .env

.DEFAULT_GOAL := help
SHELL= /bin/sh
docker_bin= $(shell command -v docker 2> /dev/null)
docker_compose_bin= $(shell command -v docker-compose 2> /dev/null)

up: ## Start all containers (in background)
	$(docker_compose_bin) -f docker-compose.yml up --no-recreate -d

down: ## Stop all started for development containers
	$(docker_compose_bin) -f docker-compose.${ENV}.yml down

install: ## Install composer and node deps
	$(docker_compose_bin) -f docker-compose.${ENV}.yml exec -T --user="${CURRENT_USER}:${CURRENT_USER_ID}" ${APACHE_CONTAINER_NAME} composer install
	$(docker_compose_bin) -f docker-compose.${ENV}.yml exec -T --workdir="${SITE_APP_DIR}" --user="${CURRENT_USER}:${CURRENT_USER_ID}" ${APACHE_CONTAINER_NAME} composer install