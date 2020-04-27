#$WorkFolder = "Temp"
#New-Item -ItemType Directory -Force -Path $WorkFolder
#Set-Location .\$WorkFolder\

$SERVERFILE="server.jar"
$downloadSiteAdress = "https://www.minecraft.net/es-es/download/server/"
if (Test-Path $SERVERFILE -PathType leaf)
{
    #Remove-Item $fileToCheck
    Write-Host "$SERVERFILE exist \n Pass"
}
else {
    Write-Host "$SERVERFILE doesn't exist."
    #Invoke-WebRequest https://path/to/file.txt -OutFile C:\file.txt
    #$MINE_VERSION= Invoke-WebRequest "https://www.minecraft.net/es-es/download/server/" -qO- | grep -P -o -m 1 "(?<=https://launcher.mojang.com/v1/objects/)[^/]+(?=/)"
    $HttpContent = Invoke-WebRequest -URI $downloadSiteAdress
    #$HttpContent.Links | Foreach {$_.href }
    #$images = $Img.Images | select src
    #$HttpContent.Links | Where-Object {$_.href -like "*https://launcher.mojang.com/v1/objects/*"} | fl innerText,href | -outvariable $catch2
    #$HttpContent.Links | Where-Object {$_.href -like "*https://launcher.mojang.com/v1/objects/*"} | fl innerText,href
    #$HttpContent.Links | Where-Object {$_.href -like "*https://launcher.mojang.com/v1/objects/*"} | URL = hre
    #$URL= https://launcher.mojang.com/v1/objects/$MINE_VERSION/server.jar

    $URL = ($HttpContent.Links | Where-Object {$_.href -like "*https://launcher.mojang.com/v1/objects/*"}).href

    Write-Host "The link to server.jar is : $URL"
    Invoke-WebRequest $URL -OutFile $SERVERFILE
}



$minram = "1G"
$maxram = "1G"
$startFileName = ".\start.ps1"
$startFileNameNogui = ".\startnogui.ps1"

$startscript = "java -Xms$minram -Xmx$maxram -jar $SERVERFILE"
$startscript | Out-File $startFileName
$startscript + " nogui" | Out-File $startFileNameNogui

& $startFileName


$EULA = @'
"*****************************************************************"
"*****************************************************************"
"**  To be able to run you need to accept minecrafts EULA see   **"
"**    https://account.mojang.com/documents/minecraft_eula      **"
"**    type (y) to accept minecraft's EULA or (n) to reject     **"
"*****************************************************************"
"*****************************************************************"
'@

Write-Host $EULA -ForegroundColor Yellow 



$eulaquest=$True

#Write-host "do you want to start the minecraft server? (Default is quit)" -ForegroundColor Yellow 
$Readhost = Read-Host " ( y. accept / n. deny ) " 
Switch ($ReadHost) 
  { 
    Y {Write-host "Accepted"; $eulaquest=$True} 
    N {Write-Host "Denied"; $eulaquest=$False}
    Default {Write-Host "Default, Denied by default, Bye Bye"; $eulaquest=$False} 
  } 

$eulapath = ".\eula.txt"
#$eulapath = "eula.txt"

$eulavar = @'
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
#Sun Apr 26 12:59:58 ART 2020
eula=true
'@

if($eulaquest -eq $True)
{ 
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
}
if($eulaquest -eq $False)
{
  Write-Host ""
  exit
}

$examplemotd = "motd=\u00a7f\u00a7lA \u00a7b\u00a7lMinecraft Server\u00a7f\u00a7l made with \u00a79\u00a7lpowershell \u00a7e\u00a7lscript\u00a7r\n\u00a7aby lukaneco\u00a7r - \u00a77github.com\/lukaneco"

$propertiespath = ".\server.properties"
if (Test-Path $propertiespath -PathType leaf)
{
    Write-Host "$propertiespath exist."
}
else {
    Write-Host "$propertiespath doesn't exist."
    #$propertiesvar -f 'string' | Out-File $propertiespath
    Write-Host "$propertiespath now it does exist"
}



#Show IP

$startvar=0

Write-host "do you want to show your public ip? (Default is quit)" -ForegroundColor Yellow 
    $Readhost = Read-Host " ( y. yes / n. no ) " 
    Switch ($ReadHost) 
     { 
       Y {Write-host "Your IP is"; $startvar= 1} 
       N {Write-Host "Ok Bro"; $startvar = 0} 
       Default {Write-Host "Default, Skip"; $startvar=0} 
     } 

if($startvar -eq 1)
{ 
  #http://woshub.com/get-external-ip-powershell/
  #Public ip
  Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)

  #Local ip
  #1..254 | ForEach-Object {Get-WmiObject Win32_PingStatus -Filter "Address='192.168.0.$_' and Timeout=200 and ResolveAddressNames='true' and StatusCode=0" | select ProtocolAddress*}
}



#GUI
$startvar=0

Write-host "do you want to start the minecraft server? (Default is quit)" -ForegroundColor Yellow 
    $Readhost = Read-Host " ( 1. start / 2. start no gui / q. quit) " 
    Switch ($ReadHost) 
     { 
       1 {Write-host "Starting Server"; $startvar= 1} 
       2 {Write-Host "Starting Server no gui mode"; $startvar = 2} 
       Q {Write-host "Quit, Bye Bye"; $startvar= 0} 
       Default {Write-Host "Default, Skip start, Bye Bye"; $startvar=0} 
     } 

if($startvar -eq 1)
{ 
    #write-output "Invalid" 
    #& ((Split-Path $MyInvocation.InvocationName) + $startFileName)
    #if are you reading this thank you to use me, bye MrScript
    & $startFileName
}
if($startvar -eq 2)
{ 
    #write-output "Invalid" 
    #& ((Split-Path $MyInvocation.InvocationName) + $startFileName)
    & $startFileNameNogui
}


