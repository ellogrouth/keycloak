# 🧪 Teste Local das Configurações do Render

Este guia explica como testar localmente as configurações que serão usadas no Render, 

## 📁 Arquivos Criados para Teste Local

- `env.render.local` - Variáveis de ambiente para teste local
- `compose.render.local.yml` - Docker Compose para teste local
- Comandos adicionados no `Makefile`

## 🚀 Como Testar Localmente

### 1. **Iniciar o Keycloak com Configurações do Render**

```bash
# Iniciar Keycloak com configurações do Render
make up-render-local
```

Este comando irá:
- ✅ Construir a imagem usando `Dockerfile.render`
- ✅ Iniciar PostgreSQL com as mesmas configurações
- ✅ Iniciar Keycloak com as configurações de produção
- ✅ Montar o tema customizado `ellogrouth`

### 2. **Verificar se está Funcionando**

```bash
# Ver logs em tempo real
make logs-render-local

# Verificar se os containers estão rodando
docker ps
```

### 3. **Acessar o Keycloak**

Após iniciar, acesse:
- **URL**: http://localhost:8080
- **Admin Console**: http://localhost:8080/admin
- **Usuário**: `admin`
- **Senha**: `admin`

### 4. **Comandos Disponíveis**

```bash
# Gerenciar o Keycloak
make up-render-local      # Iniciar
make down-render-local    # Parar
make logs-render-local    # Ver logs
make exec-render-local    # Acessar shell
make clean-render-local   # Limpar volumes
```

## 🔍 Diferenças entre Desenvolvimento e Render

### **Desenvolvimento Local (`make up`)**
- Usa `docker/Dockerfile.dev`
- Comando: `start-dev`
- Cache de temas: **desabilitado**
- Log level: `DEBUG`
- Configurações: flexíveis

### **Teste Render Local (`make up-render-local`)**
- Usa `Dockerfile.render`
- Comando: `start` (produção)
- Cache de temas: **habilitado**
- Log level: `INFO`
- Configurações: idênticas ao Render

## 🎯 O que Testar

### 1. **Funcionalidade Básica**
- [ ] Keycloak inicia sem erros
- [ ] Admin console acessível
- [ ] Login com admin/admin funciona
- [ ] Tema customizado carregado

### 2. **Configurações de Produção**
- [ ] Cache de temas funcionando
- [ ] Logs em nível INFO
- [ ] Configurações de proxy
- [ ] Conexão com PostgreSQL

### 3. **Tema Customizado**
- [ ] Tema `ellogrouth` disponível
- [ ] Recursos carregados corretamente
- [ ] Templates funcionando

## 🐛 Troubleshooting

### **Problemas Comuns**

1. **Erro de conexão com banco**:
   ```bash
   # Verificar se PostgreSQL está rodando
   docker ps | grep postgres
   
   # Ver logs do PostgreSQL
   docker compose -f compose.render.local.yml logs postgres
   ```

2. **Keycloak não inicia**:
   ```bash
   # Ver logs detalhados
   make logs-render-local
   
   # Verificar configurações
   make exec-render-local
   ```

3. **Tema não carregando**:
   ```bash
   # Verificar se tema existe
   ls -la themes/ellogrouth/
   
   # Verificar montagem no container
   make exec-render-local
   ls -la /opt/keycloak/themes/
   ```

### **Limpeza Completa**

```bash
# Parar e limpar tudo
make clean-render-local

# Ou manualmente
docker compose -f compose.render.local.yml down -v
docker system prune -f
```

## 📊 Comparação de Performance

### **Desenvolvimento vs Produção**

| Aspecto | Desenvolvimento | Render Local |
|---------|----------------|--------------|
| Startup | Rápido | Mais lento |
| Cache | Desabilitado | Habilitado |
| Logs | Verbose | Resumido |
| Estabilidade | Menor | Maior |

## ✅ Checklist de Teste

Antes de fazer deploy no Render:

- [ ] `make up-render-local` executa sem erros
- [ ] Keycloak acessível em http://localhost:8080
- [ ] Admin console funciona
- [ ] Tema customizado carregado
- [ ] Logs mostram configurações corretas
- [ ] Banco PostgreSQL conectado
- [ ] Cache de temas funcionando

## 🚀 Próximo Passo

Após testar localmente e confirmar que tudo funciona:

```bash
# Fazer deploy no Render
make deploy-render
```

**Agora você pode testar exatamente as mesmas configurações que serão usadas no Render!** 🎉

