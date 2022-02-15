#!/usr/bin/make
include .env

.DEFAULT_GOAL := help
SHELL= /bin/sh
docker_bin= $(shell command -v docker 2> /dev/null)
docker_compose_bin= $(shell command -v docker-compose 2> /dev/null)

up: ## Start all containers (in background)
	$(docker_compose_bin) -f docker-compose.yml up --no-recreate -d

down: ## Stop all started for development containers
	$(docker_compose_bin) -f docker-compose.yml down

install: ## Install composer deps
	$(docker_compose_bin) -f docker-compose.yml exec -T --workdir="${SITE_APP_DIR}" --user="${CURRENT_USER}:${CURRENT_USER_ID}" ${APACHE_CONTAINER_NAME} composer create-project symfony/skeleton:"^5.4"
	$(docker_compose_bin) -f docker-compose.yml exec -T --workdir="${SITE_APP_DIR}"/skeleton --user="${CURRENT_USER}:${CURRENT_USER_ID}" ${APACHE_CONTAINER_NAME} composer require webapp
	$(docker_compose_bin) -f docker-compose.yml exec -T --workdir="${SITE_APP_DIR}"/skeleton --user="${CURRENT_USER}:${CURRENT_USER_ID}" ${APACHE_CONTAINER_NAME} sed -i 's%${DATABASE_DEFAULT}%${DATABASE_URL}%g' .env

install-db: ## Install db after config env skeleton
	$(docker_compose_bin) run --rm "${APACHE_CONTAINER_NAME}" php skeleton/bin/console doctrine:database:create
