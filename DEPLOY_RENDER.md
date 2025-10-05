# 🚀 Deploy do Keycloak no Render

Este guia explica como fazer o deploy do Keycloak no Render usando os arquivos configurados.

## 📁 Arquivos Criados para o Deploy

- `Dockerfile` - Dockerfile otimizado para produção no Render
- `render.yaml` - Configuração automática do serviço e banco
- `env.render` - Variáveis de ambiente para referência
- Comandos adicionados no `Makefile`

## 🛠️ Passos para Deploy

### 1. Preparar o Repositório

```bash
# Adicionar todos os arquivos
git add .

# Fazer commit
git commit -m "Configure project for Render deployment"

# Fazer push
git push origin main
```

### 2. Configurar no Render Dashboard

1. **Acesse**: https://dashboard.render.com
2. **Conecte seu repositório GitHub**
3. **Crie um novo Web Service**:
   - Selecione seu repositório
   - Escolha "Docker" como ambiente
   - O `render.yaml` será detectado automaticamente
   - Clique em "Apply"

### 3. Configuração Automática

O arquivo `render.yaml` já configura:
- ✅ Web Service com Docker
- ✅ PostgreSQL Database
- ✅ Todas as variáveis de ambiente necessárias
- ✅ Conexão automática entre serviço e banco

### 4. Variáveis de Ambiente (Configuradas Automaticamente)

```bash
# Admin do Keycloak
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=[gerada automaticamente]

# Banco de dados (conectado automaticamente)
KC_DB=postgres
KC_DB_URL=[URL do banco Render]
KC_DB_USERNAME=[usuário do banco]
KC_DB_PASSWORD=[senha do banco]

# Rede
KC_HOSTNAME=[URL do seu app]
KC_PROXY=edge
KC_HOSTNAME_STRICT=false

# Cache e Performance
KC_CACHE=ispn
KC_CACHE_STACK=kubernetes
SPI_THEME_CACHE_THEMES=true
SPI_THEME_CACHE_TEMPLATES=true
```

## 🧪 Testar Localmente

Antes do deploy, teste o build:

```bash
# Testar apenas o build (recomendado)
make test-render

# Testar build completo (requer banco PostgreSQL)
make test-render-full

# Build para Render
make build-render
```

**Nota**: O comando `test-render-full` falhará localmente porque não há banco PostgreSQL rodando, mas isso é esperado. O importante é que o build funcione.

## 📋 Comandos Disponíveis

```bash
# Desenvolvimento local
make up          # Iniciar Keycloak local
make down        # Parar Keycloak local
make logs        # Ver logs
make exec        # Acessar shell do container

# Render
make build-render      # Build para Render
make test-render       # Testar build (sem execução)
make test-render-full  # Testar build completo (com execução)
make deploy-render     # Instruções de deploy
```

## 🌐 Acessar o Keycloak

Após o deploy:
- **URL**: `https://seu-app.onrender.com`
- **Admin Console**: `https://seu-app.onrender.com/admin`
- **Usuário**: `admin`
- **Senha**: [gerada automaticamente pelo Render]

## 🔧 Troubleshooting

### Problemas Comuns

1. **Build falha**:
   - Verifique se o tema `ellogrouth` existe
   - Confirme se o Dockerfile está correto

2. **Erro de conexão com banco**:
   - O `render.yaml` conecta automaticamente
   - Verifique se o banco foi criado

3. **Tema não carregando**:
   - Confirme se a pasta `themes/ellogrouth` existe
   - Verifique o `theme.properties`

### Ver Logs

1. Acesse o dashboard do Render
2. Vá para seu serviço
3. Clique na aba "Logs"

## 💰 Custos

- **Web Service**: Gratuito (plano Starter)
- **PostgreSQL**: Gratuito (plano Starter)
- **Limitações**:
  - Serviço pode "dormir" após 15 minutos de inatividade
  - 750 horas/mês de uso gratuito
  - 1GB de RAM

## 🎯 Próximos Passos

1. ✅ Deploy automático via Git
2. ✅ Banco PostgreSQL gerenciado
3. ✅ Tema customizado incluído
4. 🔄 Configurar domínio customizado (opcional)
5. 🔄 Configurar backup do banco
6. 🔄 Monitorar performance

## 📞 Suporte

Se encontrar problemas:
1. Verifique os logs no Render
2. Teste localmente com `make test-render`
3. Confirme se todos os arquivos foram commitados
