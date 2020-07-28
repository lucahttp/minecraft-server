#docker build --rm -t auth0-vue-01-login .
#docker run -p 3000:3000 --pid=host auth0-vue-01-login
#docker build --rm --tag mineserver_2:latest -f ./minecreaft.spigot.docker.dockerfile .
#docker build --rm -t minecreaft.spigot.docker.dockerfile .
#docker run -d -p 25565:25565 mineserver --pid=host mineserver_2:latest
#https://docs.docker.com/engine/reference/run/

#$Sample = Get-Random -Minimum -100 -Maximum 100
#$Sample2 = New-Guid
#echo $Sample2
docker-compose up -d

#docker build --pull --no-cache --rm -f "2.dockerfile" -t csvtodockermysql:latest "."
#docker run -i -t -d -p 3306:3306 --pid=host -v /var/lib/mysql --name mysql_container-$Sample csvtodockermysql:latest
#docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql_container-$Sample