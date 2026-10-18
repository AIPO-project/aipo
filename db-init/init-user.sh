#!/bin/sh
set -eu

echo "Configurando banco e usuário AIPO..."

mysql -h "$MYSQL_HOST" \
  -u root \
  --password="$MYSQL_ROOT_PASSWORD" <<SQL

CREATE DATABASE IF NOT EXISTS \`aipo\`;

CREATE USER IF NOT EXISTS 'aipo'@'%'
IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT SELECT, INSERT, UPDATE, DELETE
ON \`aipo\`.*
TO 'aipo'@'%';

SQL

echo "Configuração do AIPO concluída!"