apt-get update -y
apt-get install git openjdk-8-jre-headless -y
apt-get install -y net-tools
apt-get install curl -y
apt-get install software-properties-common -y


mkdir ~/mineserver && cd ~/mineserver
mkdir tmp && cd tmp
#mkdir ~/mineserver/tmp/
#cd ~/mineserver/tmp/
#curl -SLO "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar
#java -Xms512M -jar BuildTools.jar --rev latest


file=~/mineserver/tmp/BuildTools.jar
if [ -e "$file" ]; then
    echo "File exists"
else 
    echo "File does not exist"
    curl -SLO "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar
fi 



spigotfile=~/mineserver/tmp/spigot.jar
if [ -e "$spigotfile" ]; then
    echo "File exists"
else 
    echo "File does not exist"
    java -Xms512M -jar ~/mineserver/tmp/BuildTools.jar --rev latest
fi 

#moving spigot to the work folder
#cp spigot-*.jar ~/mineserver/spigot.jar

file2=~/mineserver/spigot.jar
if [ -e "$file2" ]; then
    echo "File exists"
else 
    echo "File does not exist"
    cp ~/mineserver/tmp/spigot-*.jar ~/mineserver/spigot.jar
fi 



echo    "spawn-protection=16\n"\
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
            #"server-port="${PORTS}"\n"\
            "server-port=25565\n"\
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
            "enable-rcon=false" > ~/mineserver/server.properties

cd ~/mineserver
echo "java -Xms1G -Xmx1G -jar spigot.jar" > start.sh
chmod +x start.sh
sudo ./start.sh
rm eula.txt
echo "eula=true" > eula.txt
sudo ./start.sh