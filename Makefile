# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbrassar <bbrassar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/04 15:59:19 by bbrassar          #+#    #+#              #
#    Updated: 2022/06/21 03:06:22 by bbrassar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DIR_SRC = srcs

include $(DIR_SRC)/.env

COMPOSE = docker-compose --project-directory $(DIR_SRC)
COMPOSE_ACTIONS = start stop ps kill logs

.PHONY: all
all: build

# build and create containers, without starting them
.PHONY: build
build:
	$(COMPOSE) up --build --no-start

# clear volumes
.PHONY: prune
prune:
	rm -rf $(VOLUMES_LOCATION)

# clear and remove volumes
.PHONY: clean
clean: prune
	$(COMPOSE) down -v

# clear and remove content, delete images
.PHONY: fclean
fclean: prune
	$(COMPOSE) down -v --rmi all --remove-orphans

# stop and start containers
#
# we use this instead of the default `docker-compose restart`
# because it does not respect the start order
.PHONY: restart
restart: stop start

# check the containers status
.PHONY: status
status: ps

# rebuild images, volumes and containers
.PHONY: re
re: fclean all

.PHONY: set-host
set-host:
	@echo "127.0.0.1 bbrassar.42.fr" | tee -a /etc/hosts

.PHONY: $(COMPOSE_ACTIONS)
$(COMPOSE_ACTIONS):
	$(COMPOSE) $@
