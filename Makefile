export COMPOSE_BAKE=true
COMPOSE_FILES=deploy/local/docker/compose.yaml

ifeq ($(shell docker compose version),)
  $(error "Docker Compose is not installed. Please install Docker Compose to use this Makefile.")
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
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) logs --follow --timestamps
