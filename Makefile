export COMPOSE_BAKE=true
COMPOSE_FILES=deploy/local/docker/compose.yaml

.PHONY: all
all: build

.PHONY: build
build:
	@echo "Building the project..."
	@docker compose --profile build $(foreach file, $(COMPOSE_FILES), -f $(file)) build
