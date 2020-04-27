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


