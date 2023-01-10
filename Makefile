# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbrassar <bbrassar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/04 15:59:19 by bbrassar          #+#    #+#              #
#    Updated: 2023/01/10 14:09:10 by bbrassar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DIR_SRC = srcs

include $(DIR_SRC)/.env

COMPOSE = docker compose --project-directory $(DIR_SRC)
COMPOSE_ACTIONS = start stop ps kill logs up down

.PHONY: all build prune clean fclean restart status re set-host $(COMPOSE_ACTIONS)

all: build

# build and create containers, without starting them
build:
	$(COMPOSE) up --build --no-start

# clear volumes
prune:
	rm -rf $(VOLUMES_LOCATION)

# clear and remove volumes
clean: prune
	$(COMPOSE) down -v

# clear and remove content, delete images
fclean: prune
	$(COMPOSE) down -v --rmi all --remove-orphans

# stop and start containers
#
# we use this instead of the default `docker-compose restart`
# because it does not respect the start order
restart: stop start

# check the containers status
status: ps

# rebuild images, volumes and containers
re: fclean all

set-host:
	@echo "127.0.0.1 bbrassar.42.fr" | tee -a /etc/hosts

$(COMPOSE_ACTIONS):
	$(COMPOSE) $@ $(c)
