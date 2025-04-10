export COMPOSE_BAKE=true
COMPOSE_FILES=deploy/local/docker/compose.yaml deploy/local/docker/compose.tools.yaml

ifeq ($(shell docker compose version),)
  $(error "Docker Compose is not installed. Please install Docker Compose to use this Makefile.")
endif

ifeq (logs,$(firstword $(MAKECMDGOALS)))
  LOGS_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(LOGS_ARGS):;@:)
endif

.PHONY: all
all: build

.PHONY: build
build:
	@echo "Building the project..."
	@docker compose --profile build $(foreach file, $(COMPOSE_FILES), -f $(file)) build

.PHONY: start
start:
	@echo "Starting the project..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) up -d --wait --remove-orphans

.PHONY: stop
stop:
	@echo "Stopping the project..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) down --remove-orphans

.PHONY: restart
restart: stop start

.PHONY: logs
logs:
	@echo "Showing logs..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) logs --follow --timestamps $(LOGS_ARGS)

###> Tools ###
.PHONY: phpcs
phpcs:
	@echo "Running PHP CodeSniffer..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) run --rm phpcs

.PHONY: phpmd
phpmd:
	@echo "Running PHP Mess Detector..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) run --rm phpmd \
		src,tests,apps text phpmd.xml.dist \
		--color \
		--exclude=vendor,*/vendor/*,*/var/*
###< Tools ###
