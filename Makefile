# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbrassar <bbrassar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/04 15:59:19 by bbrassar          #+#    #+#              #
#    Updated: 2022/06/06 09:41:48 by bbrassar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DIR_SRC = srcs

include $(DIR_SRC)/.env

COMPOSE = docker-compose --project-directory $(DIR_SRC)
COMPOSE_ACTIONS = start stop ps kill logs

all: build

build:
	$(COMPOSE) up --build --no-start

prune:
	rm -rf $(VOLUMES_LOCATION)

clean: prune
	$(COMPOSE) down -v

fclean: prune
	$(COMPOSE) down -v --rmi all --remove-orphans

restart: stop start

status: ps

re: fclean all

$(COMPOSE_ACTIONS):
	$(COMPOSE) $@

.PHONY: $(COMPOSE_ACTIONS) all clean
