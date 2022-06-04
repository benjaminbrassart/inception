# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbrassar <bbrassar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/04 15:59:19 by bbrassar          #+#    #+#              #
#    Updated: 2022/06/04 16:27:01 by bbrassar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DIR_SRC = srcs

COMPOSE = docker-compose --project-directory $(DIR_SRC)
COMPOSE_ACTIONS = build start stop restart ps kill

all: build
	$(COMPOSE) up

clean:
	$(COMPOSE) down -v --rmi all

status: ps

$(COMPOSE_ACTIONS):
	$(COMPOSE) $@

.PHONY: $(COMPOSE_ACTIONS) all clean
