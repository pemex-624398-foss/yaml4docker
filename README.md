# YAML for Docker


## Requisitos
* [Docker](https://www.docker.com/get-started/)
* [Docker Compose](https://docs.docker.com/compose/)


# Comandos Útiles
* ls
* tree
* vi
* cat
* more
* less
* grep
* echo
* chmod
* htpasswd
* cut
* sed
* yq
* highlight
* history


## Uso de Scripts

### Permisos
```shell
# Opción 1
chmod u+x demo1.sh
chmod u+x demo2.sh

# Opción 2
chmod 744 demo1.sh
chmod 744 demo2.sh
```

### demo1.sh
```shell
# Uso incorrecto
./demo1.sh
# Visualizar valor de retorno
echo $?

# Uso correcto
./demo1.sh Adrian Aviles 624398
# Visualizar valor de retorno
echo $?
```

### demo2.sh
```shell
# Ejecutar un comando posterior condicionalmente
./demo2.sh Adrian Aviles 624398 && echo "Command succeeded" || echo "Command failed"
```



## Ejecución Manual de Servicios
### 1. Descargar imágenes Docker
* Sitios Web
  - joomla:4.1.5 (Institucional)
  - wordpress:6.0.0 (Capital Humano)
* Bases de datos
  - mysql:6.0.0 (Joomla y Wordpress)
  - phpmyadmin/phpmyadmin:5.0.0: (administración de bases de datos)
* Monitoreo de Servicios
  - portainer/portainer-ce:2.14.0

```shell
docker pull "$IMAGE:$TAG"
```

### 2. Creación de Redes
* yaml4docker-frontend
  - Joomla
  - Wordpress
* yaml4docker-backend
  - MySQL
  - PhpMyAdmin
  - Joomla
  - Wordpress

```shell
docker network create "$NETWORK"
```

### 3. Creación de Volúmenes
* yaml4docker_db-mysql
* yaml4docker_web-institucional-html
* yaml4docker_web-ch-html
* yaml4docker_mon-portainer-data

```shell
docker volume create "$VOLUME"
```

### 4. Ejecución de Contenedores
* MySQL
* PhpMyAdmin
* Joomla
* Wordpress
* Portainer

```shell
# Ejecutar
docker run --name $CONTAINER_NAME -p "$HOST_PORT:$CONTAINER_PORT" -e VAR1=$VALUE1 -e VAR2=$VALUE2 -d $IMAGE:$TAG

# Detener
docker stop $CONTAINER_NAME

# Iniciar
docker start $CONTAINER_NAME
```

### 5. Destruir Servicios
```shell
# Detener contenedor
docker stop $CONTAINER_NAME

# Eliminar contenedor
docker rm $CONTAINER_NAME

# Eliminar volúmenes
docker volume rm $VOLUME

# Eliminar redes
docker network rm $NETWORK
```


## Ejecución Automatizada de Servicios

### Portainer Pasword Hash
```shell
# Obtener user:hash
htpasswd -nb -B admin pleaseletmein

# Obtener sólo hash
htpasswd -nb -B admin pleaseletmein | cut -d ":" -f 2

# Remplazar $ por $$
htpasswd -nb -B admin pleaseletmein | cut -d ":" -f 2 | sed -e 's/\$/\$\$/g'
```

### Permisos de Ejecución
```shell
chmod u+x start.sh
chmod u+x stop.sh
chmod u+x destroy.sh
```

### Iniciar Servicios
```shell
./start.sh && open http://localhost:9000
```

### Detener Servicios
```shell
./stop.sh
```

### Destruir Servicios
```shell
./destroy.sh
```

