
```dockerfile
# Dockerfile para Render
FROM quay.io/keycloak/keycloak:26.3.4

# Copiar temas customizados
COPY ./themes/ /opt/keycloak/themes/

# Configurar para produção
ENV KC_DB=postgres
ENV KC_CACHE=ispn
ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HTTP_ENABLED=true

# Configurar cache de temas para produção
ENV SPI_THEME_CACHE_THEMES=true
ENV SPI_THEME_CACHE_TEMPLATES=true

# Configurar porta para o Render
ENV KC_HTTP_PORT=8080
ENV PORT=8080

WORKDIR /opt/keycloak

# Expor porta
EXPOSE 8080

# Comando para produção
CMD ["/opt/keycloak/bin/kc.sh", "start"]
```

### 2. **render.yaml Corrigido**

```yaml
services:
  - type: web
    name: keycloak
    env: docker
    dockerfilePath: ./Dockerfile.render  # ✅ Corrigido
    plan: starter
    region: oregon
    branch: main
    healthCheckPath: /health
    port: 8080  # ✅ Adicionado
    envVars:
      # ... outras variáveis ...
      - key: KC_HTTP_PORT
        value: 8080  # ✅ Adicionado
      - key: PORT
        value: 8080  # ✅ Adicionado
```

### 3. **Makefile Corrigido**

```makefile
# Comandos para Render
build-render:
	@echo "Buildando para Render"
	docker build -f Dockerfile.render -t keycloak-render .  # ✅ Corrigido

test-render:
	@echo "Testando build do Render"
	docker build -f Dockerfile.render -t keycloak-render .  # ✅ Corrigido

test-render-full:
	@echo "Testando build e execução completa do Render"
	docker build -f Dockerfile.render -t keycloak-render . && \
	docker run --rm -p 8080:8080 keycloak-render  # ✅ Corrigido
```

## 🧪 **Teste Local (Recomendado)**

Antes de fazer o deploy, teste localmente:

```bash
# Testar build
make test-render

# Testar execução completa
make test-render-full

# Ou teste com configurações completas
make up-render-local
```

## 🚀 **Deploy no Render**

### 1. **Commit das Correções**

```bash
git add .
git commit -m "Fix: Corrigir problema de porta no Render"
git push origin main
```

### 2. **Deploy no Render**

1. Acesse: https://dashboard.render.com
2. Conecte seu repositório
3. O `render.yaml` será usado automaticamente
4. O Render agora deve detectar a porta 8080 corretamente

## 🔍 **Verificações Pós-Deploy**

Após o deploy, verifique:

- [ ] ✅ Serviço inicia sem erro de porta
- [ ] ✅ Keycloak acessível na URL fornecida
- [ ] ✅ Admin console funciona
- [ ] ✅ Tema customizado carregado
- [ ] ✅ Banco PostgreSQL conectado

## 📊 **Diferenças das Correções**

| Aspecto | Antes | Depois |
|---------|-------|--------|
| Dockerfile | `./Dockerfile` | `./Dockerfile.render` |
| Comando | `ENTRYPOINT + CMD` | `CMD` apenas |
| Porta | `EXPOSE 8080` | `EXPOSE + ENV PORT + ENV KC_HTTP_PORT` |
| render.yaml | Sem `port: 8080` | Com `port: 8080` |
| Variáveis | Sem `PORT` | Com `PORT` e `KC_HTTP_PORT` |

## 🎯 **Resultado Esperado**

Agora o Render deve:

1. ✅ Detectar a porta 8080 automaticamente
2. ✅ Iniciar o Keycloak corretamente
3. ✅ Conectar com o banco PostgreSQL
4. ✅ Carregar o tema customizado
5. ✅ Estar acessível via URL pública

## 🆘 **Se Ainda Houver Problemas**

Se o erro persistir, verifique:

1. **Logs do Render**: Acesse os logs no dashboard
2. **Configuração do banco**: Verifique se as variáveis de banco estão corretas
3. **Tema customizado**: Verifique se o tema existe em `themes/ellogrouth/`

## 🎉 **Próximos Passos**

Após o deploy bem-sucedido:

1. ✅ Acesse a URL do Keycloak
2. ✅ Faça login com `admin` / senha gerada
3. ✅ Configure seu realm
4. ✅ Teste o tema customizado
5. ✅ Configure usuários e clientes

**Agora o deploy deve funcionar perfeitamente!** 🚀
