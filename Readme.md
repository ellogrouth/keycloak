# Keycloak

Este repositório contém a configuração para rodar o **Keycloak** usando **Docker** e **Docker Compose**, facilitando o desenvolvimento e a produção.

---

## Estrutura do Projeto

```text
.
├── compose.yml            # Arquivo principal do Docker Compose
├── config
│   └── themes             # Pasta para temas de Keycloak
├── docker
│   ├── Dockerfile.dev     # Dockerfile para ambiente de desenvolvimento
│   └── Dockerfile.prod    # Dockerfile para ambiente de produção
├── Makefile               # Automatiza comandos Docker e Compose
├── Readme.md              # Este arquivo
└── themes
    └── onlyizi            # Tema customizado para Keycloak
        ├── resources
        ├── templates
        └── theme.properties
```

./compose.yml → Configura os serviços Docker necessários, incluindo Keycloak.
./themes → Local para colocar temas customizados que podem ser usados pelo Keycloak.
./docker/Dockerfile.dev → Dockerfile para desenvolvimento.
./docker/Dockerfile.prod → Dockerfile para produção.
./themes/ellogrouth → Tema customizado com recursos, templates e configuração do tema.

--

## Como Rodar o Projeto

- Iniciar o Keycloak (Desenvolvimento)
  `make up`

- Parar o Keycloak
  `make down`

- Ver logs do Keycloak
  `make logs`

- Acessar o shell do container
  `make exec`

- Build da imagem de produção
  `make build-prod`

- Rodar Keycloak em produção
  `make run-prod`

---

## Observações

.env.dev → Contém variáveis de ambiente para desenvolvimento.
.env → Contém variáveis de ambiente para produção.
É recomendável usar o make clean de vez em quando para manter o Docker limpo.
