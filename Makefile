include srcs/.env

COMPOSE_FILE	= ./srcs/docker-compose.yml
VOLUMES			= $(shell docker volume ls -q)

prep:
	echo 127.0.0.1 ${DOMAIN_NAME} | sudo tee -a /etc/hosts

up: 
	docker-compose -f $(COMPOSE_FILE) up --build -d

down:
	docker-compose -f $(COMPOSE_FILE) down

nginx wordpress mariadb:
	docker-compose -f $(COMPOSE_FILE) exec $@ /bin/sh

clean:
	./reset.sh
ifneq ($(VOLUMES),)
	docker volume rm $(VOLUMES)
endif



re: down up
