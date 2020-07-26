#docker build --rm -t auth0-vue-01-login .
#docker run -p 3000:3000 --pid=host auth0-vue-01-login
docker build --rm --tag mineserver_2:latest -f ./minecreaft.spigot.docker.dockerfile .
#docker build --rm -t minecreaft.spigot.docker.dockerfile .
docker run -d -p 25565:25565 mineserver --pid=host mineserver_2:latest
#https://docs.docker.com/engine/reference/run/