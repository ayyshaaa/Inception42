all:
	cd ./srcs/requirements/tools && sh ./generate_env.sh
	cd ./srcs && docker compose up -d

clean: 
	cd ./srcs && docker compose down --volumes --remove-orphans
	docker system prune -f
	rm -rf ./srcs/.env
	sudo rm -rf ./srcs/requirements/mariadb/data/*

re: clean all

.PHONY: all clean re