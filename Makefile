# Inicia o docker
docker:
	sudo docker compose up

bundle:
	sudo docker compose run rails bundle install

# Necessario quando precisar rodar algum comando no servidor
bash:
	sudo docker compose exec rails /bin/bash

# Quando for preciso usar o byebug usar esse comando com o parametro container=<NOME-CONTAINER>
debug:
# Para sair da tela deste comando, CTRL + P CTRL + Q
ifeq ($(container),)
	echo "Para container padrão restaurant-project"
	sudo docker attach restaurant-project
else
	echo "Para container customizado"
	sudo docker attach $(container)
endif

# Quando for necessário reiniciar a aplicação sem derrubar todos os containers
restart:
ifeq ($(container),)
	echo "Para container padrão restaurant-project"
	sudo rm tmp/pids/server.pid
	sudo docker restart restaurant-project
	sudo docker-compose up
else
	echo "Para container customizado"
	sudo rm tmp/pids/server.pid
	sudo docker restart $(container)
	sudo docker compose up
endif
