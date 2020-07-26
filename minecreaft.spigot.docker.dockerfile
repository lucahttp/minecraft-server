FROM ubuntu:latest

#ENV MINEPORT 25565
#ENV MINEPORT="25565"

ENV MINEPORT=25565
#ARG MINEPORT=25565
ENV MCVERSION=1.15.2
#ARG MY_SERVICE_PORT_RPC=50051
ARG DEBIAN_FRONTEND=noninteractive
# requires software-properties-common package to use ppas
RUN apt-get update -y
#RUN apt-get upgrade -y
RUN apt-get update &&\
 apt-get install -y software-properties-common &&\
 add-apt-repository universe
#RUN apt-get -y --no-install-recommends install \ curl \ apt-transport-https \ ca-certificates \ software-properties-common

#Fuente: https://www.enmimaquinafunciona.com/pregunta/140521/instalacion-de-ventana-acoplable-en-ubuntu-1604---configuracion-de-repositorio
#RUN apt-get install software-properties-common -y
RUN apt-get install wget -y
RUN apt-get install curl -y
#RUN apt-get update -y
#RUN apt-add-repository ppa:webupd8team/java
#RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
#RUN apt-get install oracle-java8-installer -y
RUN apt-get install -y openjdk-11-jre-headless wget -y
RUN apt-get install -y net-tools


RUN mkdir /mineserver && cd /mineserver && mkdir tmp
RUN useradd -r -U minecraft
RUN chown -R minecraft:minecraft /mineserver && chmod -R 777 /mineserver
WORKDIR /mineserver
#USER minecraft
#ADD --chown=minecraft:minecraft minecraft.server.properties server.properties
#ADD --chown=minecraft:minecraft whitelist.json whitelist.json



#RUN MINE_VERSION=$(wget "https://www.minecraft.net/es-es/download/server/" -qO- | grep -P -o -m 1 "(?<=https://launcher.mojang.com/v1/objects/)[^/]+(?=/)") \
#    && echo $MINE_VERSION \
#    #&& URL=$(https://launcher.mojang.com/v1/objects/$MINE_VERSION/server.jar) \
#    && curl -SLO "https://launcher.mojang.com/v1/objects/$MINE_VERSION/server.jar" -o "server.jar"






WORKDIR /mineserver/tmp/
RUN echo "downloading"
RUN curl -SLO "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar


RUN apt-get install -y git
RUN echo "compiling"
RUN java -Xms512M -jar /mineserver/tmp/BuildTools.jar --rev latest



RUN echo "coping executable"
RUN cp /mineserver/tmp/spigot-*.jar /mineserver/spigot.jar
#MINE_VERSION=$(wget "https://mcversions.net/" -qO- | grep -P -o -m 1 "(?<=https://launcher.mojang.com/v1/objects/)[^/]+(?=/)")
#//*[@id="MCVERSION"]/div[2]/a






WORKDIR /mineserver/

#RUN java -Xms1G -Xmx1G -jar spigot.jar
#RUN rm eula.txt

# Accept the end-user license agreement
RUN echo "eula=true" > eula.txt



#RUN rm server.properties
# https://lukaneco.github.io/Script-bash-to-Dockerfile/
RUN echo    "spawn-protection=16\n"\
            "max-tick-time=60000\n"\
            "query.port=25565\n"\
            "generator-settings=\n"\
            "force-gamemode=false\n"\
            "allow-nether=true\n"\
            "enforce-whitelist=false\n"\
            "gamemode=survival \n"\
            "broadcast-console-to-ops=true \n"\
            "enable-query=false\n"\
            "player-idle-timeout=0\n"\
            "difficulty=easy\n"\
            "spawn-monsters=true\n"\
            "broadcast-rcon-to-ops=true\n"\
            "op-permission-level=4\n"\
            "pvp=true\n"\
            "snooper-enabled=true\n"\
            "level-type=default\n"\
            "hardcore=false\n"\
            "enable-command-block=false\n"\
            "max-players=20\n"\
            "network-compression-threshold=256\n"\
            "resource-pack-sha1=\n"\
            "max-world-size=29999984\n"\
            "function-permission-level=2\n"\
            "rcon.port=25575\n"\
            "server-port="${MINEPORT}"\n"\
            "server-ip=\n"\
            "spawn-npcs=true\n"\
            "allow-flight=false\n"\
            "level-name=world\n"\
            "view-distance=10\n"\
            "resource-pack=\n"\
            "spawn-animals=true\n"\
            "white-list=false\n"\
            "rcon.password=\n"\
            "generate-structures=true\n"\
            "online-mode=false\n"\
            "max-build-height=256\n"\
            "level-seed=\n"\
            "prevent-proxy-connections=false\n"\
            "use-native-transport=true\n"\
            "motd=Minecraft Server Docker\n"\
            "enable-rcon=false" > server.properties


#RUN echo "java -Xms1G -Xmx1G -jar spigot.jar" > start.sh
#RUN chmod +x start.sh
#RUN sudo ./start.sh

#RUN sudo ./start.sh

#"server-port=25565\n"\
#VERSION=1.7.3
#MINE_VERSION=$(wget "https://mcversions.net/download/$VERSION" -qO- | grep -P -o -m 1 "(?<=*/server.jar)[^/]+(?=/)")
#MINE_VERSION=$(wget "https://mcversions.net/download/1.7.3" -qO- | grep -P -o -m 1 "(?<=https://launcher.mojang.com/v1/objects/*/server.jar)[^/]+(?=/)")


#RUN echo 'root' | passwd 'root'

#RUN passwd 'root' | echo 'root'

#RUN echo 'admin' | passwd 
#RUN echo 'root:Docker!' | chpasswd

#EXPOSE 9999/tcp
#EXPOSE ${MINEPORT}
EXPOSE 25565

#docker run -it --detach --name myminecraftserver --publish 25565:25565 minecraftserverdocker:myown

ENV MCRAMIN=1G
ENV MCRAMAX=2G
CMD "/bin/sh" "-c" "/usr/bin/java -Xms$MCRAMIN -Xmx$MCRAMAX -jar spigot.jar nogui"
#https://minecraft.gamepedia.com/Tutorials/Ubuntu_startup_script
#CMD "/bin/sh" "-c" "java -Xms1G -Xmx1G -jar spigot.jar nogui"
