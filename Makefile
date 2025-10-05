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

# Comandos para Render
build-render:
	@echo "Buildando para Render"
	docker build -f Dockerfile.render -t keycloak-render .

test-render:
	@echo "Testando build do Render"
	docker build -f Dockerfile.render -t keycloak-render .

test-render-full:
	@echo "Testando build e execução completa do Render"
	docker build -f Dockerfile.render -t keycloak-render . && \
	docker run --rm -p 8080:8080 keycloak-render

deploy-render:
	@echo "Fazendo deploy no Render"
	@echo "1. Faça commit das alterações:"
	@echo "   git add ."
	@echo "   git commit -m 'Deploy to Render'"
	@echo "   git push origin main"
	@echo "2. Acesse: https://dashboard.render.com"
	@echo "3. Conecte seu repositório"
	@echo "4. Use o render.yaml para configuração automática"

# Comandos para teste local do Render
up-render-local:
	@echo "Iniciando Keycloak com configurações do Render (local)"
	docker compose -f compose.render.local.yml --env-file env.render.local up -d --build

down-render-local:
	@echo "Parando Keycloak com configurações do Render (local)"
	docker compose -f compose.render.local.yml --env-file env.render.local down

logs-render-local:
	@echo "Ver logs do Keycloak (configurações Render)"
	docker compose -f compose.render.local.yml --env-file env.render.local logs -f keycloak

exec-render-local:
	@echo "Acessar shell do Keycloak (configurações Render)"
	docker compose -f compose.render.local.yml --env-file env.render.local exec keycloak sh

clean-render-local: down-render-local
	@echo "Limpando volumes do teste Render local"
	docker volume prune -f
	docker network prune -f
