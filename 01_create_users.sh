#!/bin/bash
set -xe

create_new_user_role_and_db() {
# change the environmental variables(at least DICTYUSER_USER,DICTYUSER_PASSWORD and DICTYUSER_DB
# here) accordingly as defined in the Dockerfile
    if [ "${DICTYUSER_USER+defined}" -a "${DICTYUSER_PASSWORD+defined}" -a "${DICTYUSER_DB+defined}" ]
    then
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
            CREATE ROLE $DICTYUSER_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$DICTYUSER_PASSWORD';
            CREATE DATABASE $DICTYUSER_DB OWNER $DICTYUSER_USER;
EOSQL
    fi
}

main() {
    create_new_user_role_and_db
}

main



