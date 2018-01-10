#!/bin/bash
set -xe

create_new_user_role_and_db() {
# change the environmental variables(at least ENV_USER,ENV_PASSWORD and ENV_DB
# here) accordingly as defined in the Dockerfile
    if [ "${ENV_USER+defined}" -a "${ENV_PASSWORD+defined}" -a "${ENV_DB+defined}" ]
    then
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
            CREATE ROLE $ENV_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$ENV_PASSWORD';
            CREATE DATABASE $ENV_DB OWNER $ENV_USER;
EOSQL
    fi
}

main() {
    create_new_user_role_and_db
}

main



