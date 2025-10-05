#!/bin/bash

# Script de inicialização do Keycloak para Render
echo "🚀 Iniciando Keycloak no Render..."

# Verificar variáveis de ambiente
echo "📋 Verificando variáveis de ambiente:"
echo "KC_DB: $KC_DB"
echo "KC_DB_URL: $KC_DB_URL"
echo "KC_DB_USERNAME: $KC_DB_USERNAME"
echo "KC_HOSTNAME: $KC_HOSTNAME"
echo "PORT: $PORT"
echo "KC_HTTP_PORT: $KC_HTTP_PORT"

# Aguardar banco de dados estar disponível
echo "⏳ Aguardando banco de dados..."
sleep 20

# Verificar se as variáveis estão definidas
if [ -z "$KC_DB_URL" ]; then
    echo "❌ ERRO: KC_DB_URL não está definida!"
    exit 1
fi

if [ -z "$KC_DB_USERNAME" ]; then
    echo "❌ ERRO: KC_DB_USERNAME não está definida!"
    exit 1
fi

echo "✅ Variáveis de banco verificadas"

# Configurar usuário administrador
echo "👤 Configurando usuário administrador..."
cd /opt/keycloak
./bin/kc.sh bootstrap-admin user --username=admin --password=admin

# Iniciar Keycloak
echo "🎯 Iniciando Keycloak..."
exec ./bin/kc.sh start
