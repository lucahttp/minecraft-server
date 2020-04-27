#apt-get update -y
#apt-get install git openjdk-8-jre-headless -y
#apt-get install -y net-tools
#apt-get install curl -y
#apt-get install software-properties-common -y


#mkdir ~/mineserver
#cd ~/mineserver
#mkdir tmp 
#cd tmp
#mkdir ~/mineserver/tmp/
#cd ~/mineserver/tmp/
#curl -SLO "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar
#java -Xms512M -jar BuildTools.jar --rev latest



#https://stackoverflow.com/questions/31879814/check-if-a-file-exists-or-not-in-windows-powershell

#file=~/mineserver/tmp/BuildTools.jar

#curl -SLO "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar" -o BuildTools.jar

$WorkFolder = "Temp"

New-Item -ItemType Directory -Force -Path $WorkFolder

Set-Location .\$WorkFolder\


$ToBuildSpigot = "BuildTools.jar"
if (Test-Path $ToBuildSpigot -PathType leaf)
{
    #Remove-Item $fileToCheck
    Write-Host "$ToBuildSpigot exist."
}
else {
    Write-Host "$ToBuildSpigot doesn't exist."
    Invoke-WebRequest https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -OutFile $ToBuildSpigot
    #Invoke-WebRequest https://path/to/file.txt -OutFile C:\file.txt
}





$Spigot = "spigot.jar" #First folder to check the file
if (Test-Path $Spigot -PathType leaf)
{
    #Remove-Item $fileToCheck
    Write-Host "$Spigot exist."
}
else {
    Write-Host "$Spigot doesn't exist."
    #Invoke-WebRequest https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -OutFile $ToBuildSpigot
    #Invoke-WebRequest https://path/to/file.txt -OutFile C:\file.txt
    java -Xms512M -jar $ToBuildSpigot --rev latest
}


Copy-Item spigot-*.jar ../spigot.jar
Set-Location ../


$propertiespath = "server.properties"

$propertiesvar = @'
#Minecraft server properties
#Sun Apr 26 12:59:58 ART 2020
spawn-protection=16
max-tick-time=60000
query.port=25565
generator-settings=
force-gamemode=false
allow-nether=true
enforce-whitelist=false
gamemode=survival
broadcast-console-to-ops=true
enable-query=false
player-idle-timeout=0
difficulty=easy
broadcast-rcon-to-ops=true
spawn-monsters=true
op-permission-level=4
pvp=true
snooper-enabled=true
level-type=default
hardcore=false
enable-command-block=false
network-compression-threshold=256
max-players=20
max-world-size=29999984
resource-pack-sha1=
function-permission-level=2
rcon.port=25575
server-port=25565
debug=false
server-ip=
spawn-npcs=true
allow-flight=false
level-name=world
view-distance=10
resource-pack=
spawn-animals=true
white-list=false
rcon.password=
generate-structures=true
online-mode=false
max-build-height=256
level-seed=
prevent-proxy-connections=false
use-native-transport=true
motd=\u00a7f\u00a7lA \u00a7b\u00a7lMinecraft Server\u00a7f\u00a7l made with \u00a79\u00a7lpowershell \u00a7e\u00a7lscript\u00a7r\n\u00a7aby lukaneco\u00a7r - \u00a77github.com\/lukaneco
enable-rcon=false
'@
#https://minecraft.tools/en/motd.php
#motd=A Minecraft Server made with powershell script
#Write-Host "$MultilineComment"


if (Test-Path $propertiespath -PathType leaf)
{
    Write-Host "$propertiespath exist."
}
else {
    Write-Host "$propertiespath doesn't exist."
    $propertiesvar -f 'string' | Out-File $propertiespath
    Write-Host "$propertiespath now it does exist"
}



$eulapath = "eula.txt"

$eulavar = @'
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Sun Apr 26 12:59:58 ART 2020
eula=true
'@

#$eulavar -f 'string' | Out-File $eulapath


#$eulatemp = (Get-Content -path $eulapath -Raw) -replace 'false','true'

#((Get-Content -path $eulapath -Raw) -replace 'false','true') | Set-Content -Path $eulapath


#cd ~/mineserver
#echo "java -Xms1G -Xmx1G -jar spigot.jar" > start.sh

$minram = "1G"
$maxram = "1G"

$startscript = "java -Xms$minram -Xmx$maxram -jar spigot.jar"
$startscript | Out-File start.ps1
$startscript + " nogui" | Out-File startnogui.ps1


#& ((Split-Path $MyInvocation.InvocationName) + "start.ps1")


#Write-Host "Running doesn't exist."

if (Test-Path $eulapath -PathType leaf)
{
    Write-Host "$eulapath exist."
    ((Get-Content -path $eulapath -Raw) -replace 'false','true') | Set-Content -Path $eulapath
}
else {
    Write-Host "$eulapath doesn't exist."
    $eulavar -f 'string' | Out-File $eulapath
    Write-Host "$eulapath now it does exist"
}




#chmod +x start.sh
#sudo ./start.sh
#rm eula.txt
#echo "eula=true" > eula.txt
#sudo ./start.sh