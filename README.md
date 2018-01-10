# Postgresql docker image
This is a source repository for [docker](http://docker.io) image designed to
run `dictyuser` database instance in docker container. It is based on the
generic alpine postgresql [image](https://store.docker.com/images/postgres).
The documentation of base docker image is also applicable here.

## Supported tags
- [1.0.0, latest (Dockerfile)](https://github.com/dictybase-docker/dictyuser-postgres/blob/1.0.0/Dockerfile)

## Additional features
### Configuration files
Bunch of modular configuration files are provided for fined grained database
configurations The following `conf` files are provided.

```
01resource.conf
02wal.conf
03query.conf
04.log.conf
05vaccum.conf
```

They get sourced in order by the `postgresql.conf` file provided by the image.
The configuration file is kept in `/etc/postgresql/postgresql.conf` and can be
use by providing an option on the docker run line(see below for instructions). 

### Environmental variables
## For creating superuser
It inherits all of
[them](https://github.com/docker-library/docs/tree/master/postgres#environment-variables).

## For regular user
Provide a set of environmental variables to create a regular(not superuser)
user, password and database during the initialization process. The following
environmental variables should be used setting them up...

```
DICTYUSER_USER  -  dictyuser(default)
DICTYUSER_PASSWORD - userpass(default)
DICTYUSER_DB - dictyuser(default)
```

## Usage
It's identical to the base image, read the documentation
[here](https://store.docker.com/images/postgres)
### Database configuration
To use the provided custom configuration(`/etc/postgresql/postgresql.conf`) run the image with the `--config-file` option
``` 
docker run --rm -d dictybase/postgres postgres -c '--config-file=/etc/postgresql/postgresql.conf'
```

All other options available in the `.conf` file can be set by passing the `-c` option to the `postgres` daemon. 
```
docker run -d --name some-postgres postgres -c 'shared_buffers=256MB' -c 'max_connections=200'
```

For details look [here](https://github.com/docker-library/docs/tree/master/postgres#database-configuration)


## Deploy
The container is intended to be deployed in [kubernetes](http://kubernetes.io)
using [helm](https://github.com/kubernetes/helm). Use the corresponding
[chart](https://github.com/dictybase-docker/kubernetes-charts/tree/master/dictyuser-postgres)
for deployment. 
