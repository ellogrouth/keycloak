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
sleep 10

# Iniciar Keycloak
echo "🎯 Iniciando Keycloak..."
exec /opt/keycloak/bin/kc.sh start
