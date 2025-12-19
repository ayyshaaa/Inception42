all:
	mkdir -p ../data/wordpress-nginx-volume
	mkdir -p ../data/mariadb-volume
	cd ./srcs/requirements/tools && sh ./generate_env.sh
	cd ./srcs && docker compose up -d --build

down:
	cd ./srcs && docker compose down --volumes --remove-orphans

clean: down
	docker system prune -a -f

fclean: clean
	sudo rm -rf ../data
	rm -rf ./srcs/.env

re: fclean all

.PHONY: all down clean fclean re
