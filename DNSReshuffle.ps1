#Below please enter index of your interface (Check using 'netsh interface ipv4 show interfaces') and ip addresses to be tested (in order of preference)
$INTERFACE_INDEX = 23
$DNS_IPS = "1.1.1.1", "1.1.1.0", "1.0.0.1", "37.235.1.174", "37.235.1.177", "208.67.222.222", "208.67.220.220"


$okIPs = @()

for($i = 0; ($i -lt $DNS_IPS.length) -and ($okIPs.length -lt 2); $i += 1){
	Write-Host "Testing $($DNS_IPS[$i])"
	$result = Test-Connection -Count 2 -Quiet -ComputerName $DNS_IPS[$i]
	
	if($result -eq $True){
		$okIPs += $DNS_IPS[$i]
	}else{
		Write-Host "$($DNS_IPS[$i]) is unreachable"
	}
}

if($okIPs.length -lt 2){
	Write-Host "No valid DNS servers found, configuration unchanged"
}else{	
	Write-Host "Changing DNS configuration of interface '$(((netsh interface ipv4 show interfaces | Where-Object {($_ -split "\s+")[1] -eq 23}) -split "\s+")[5])' to $($okIPs[0]), $($okIPs[1])"
	Set-DnsClientServerAddress -interfaceIndex 23 -ServerAddresses ($okIPs[0], $okIPs[1])
}