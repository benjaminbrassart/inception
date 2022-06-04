# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bbrassar <bbrassar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/06/04 15:59:19 by bbrassar          #+#    #+#              #
#    Updated: 2022/06/04 17:54:33 by bbrassar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DIR_SRC = srcs

COMPOSE = docker-compose --project-directory $(DIR_SRC)
COMPOSE_ACTIONS = build start stop restart ps kill logs

all:
	@$(COMPOSE) up --build --no-start

clean:
	@$(COMPOSE) down -v
	@docker volume rm -f v_database

fclean: clean
	@$(COMPOSE) down --rmi all

status: ps

re: fclean all

$(COMPOSE_ACTIONS):
	@$(COMPOSE) $@

.PHONY: $(COMPOSE_ACTIONS) all clean
