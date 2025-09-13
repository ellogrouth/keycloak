COMPOSE_FILE=compose.yml
ENV_FILE=.env.dev

up:
	@echo "Iniciando isso aqui ooo"
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d --build

down:
	@echo "Parando tudo que tá aqui ooo"
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down

clean: down
	@echo "Fazendo limpeza"
	docker volume prune -f
	docker network prune -f

logs:
	@echo "Oia o log chegando"
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) logs -f keycloak

exec:
	@echo "Vamo inspecionar isso aqui ooo"
	docker compose -f $(COMPOSE_FILE) --env-file $(ENV_FILE) exec keycloak sh

build-prod:
	@echo "Grandes chances de dar merda cuidado"
	docker build -f docker/Dockerfile.prod -t keycloak-prod .

run-prod:
	@echo "Se não quebrou aqui fica feliz"
	docker run -d \
		--name keycloak-prod \
		--env-file .env \
		-p 8080:8080 \
		-p 8443:8443 \
		keycloak-prod
