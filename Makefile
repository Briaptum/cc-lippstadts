.PHONY: up stop

# Minimal dev lifecycle for cc-lippstadt

up:
	@echo "Starting cc-lippstadt stack..."
	@if [ ! -f .env ]; then \
		echo "Creating .env from env.example..."; \
		cp env.example .env; \
	fi
	@docker-compose -f docker-compose.local.yml up --build -d
	@echo "Services are starting. Frontend: http://localhost:3000 · Backend: http://localhost:8080"

stop:
	@echo "Stopping cc-lippstadt stack..."
	@docker-compose -f docker-compose.local.yml down
	@echo "Services stopped."