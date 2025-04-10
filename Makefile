export COMPOSE_BAKE=true
COMPOSE_FILES=deploy/local/docker/compose.yaml

.PHONY: all
all: build

.PHONY: build
build:
	@echo "Building the project..."
	@docker compose --profile build $(foreach file, $(COMPOSE_FILES), -f $(file)) build

.PHONY: start
start:
	@echo "Starting the project..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) up -d

.PHONY: stop
stop:
	@echo "Stopping the project..."
	@docker compose $(foreach file, $(COMPOSE_FILES), -f $(file)) down
