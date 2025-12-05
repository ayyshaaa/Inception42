all:
	cd ./srcs/requirements/tools && sh ./generate_env.sh
	cd ./srcs && docker compose up -d

clean:
	cd ./srcs && docker compose down --volumes --remove-orphans
	docker system prune -a -f
	rm -rf ./srcs/.env
	sudo rm -rf ../data/mariadb-volume/*
	sudo rm -rf ../data/wordpress-nginx-volume/*

re: clean all

.PHONY: all clean re
