#http://woshub.com/get-external-ip-powershell/
Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)

#Local Network

1..254 | ForEach-Object {Get-WmiObject Win32_PingStatus -Filter "Address='192.168.0.$_' and Timeout=200 and ResolveAddressNames='true' and StatusCode=0" | select ProtocolAddress*}