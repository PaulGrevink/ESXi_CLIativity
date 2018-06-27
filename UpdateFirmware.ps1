$VMhostName = "esx01"
$VMhostUser = "root"
$VMhostPass = "pw"

$HostInfo = Get-VMHost -Name $VMhostName
$VMhostService = Get-VMHost -Name $VMhostName | Get-VMHostService | Where { $_.Key -eq "TSM-SSH"} 
Start-VMHostService -HostService $VMhostService

if ($HostInfo.Model -eq "ProLiant DL380 Gen9" ) {
    Write-Host "This is a ProLiant DL380 Gen9"
    & "C:\Program Files (x86)\PuTTY\pscp.exe" -l $VMhostUser -pw $VMhostPass -r DL380Gen9\ ${VMhostName}:/tmp
    & "C:\Program Files (x86)\PuTTY\plink.exe" $VMhostUser@$VMhostName -pw $VMhostPass -m .\firmware.plink
}
 
if ($HostInfo.Model -eq "ProLiant DL580 Gen9" ) {
    Write-Host "This is a ProLiant DL580 Gen9"
    & "C:\Program Files (x86)\PuTTY\pscp.exe" -l $VMhostUser -pw $VMhostPass -r DL580Gen9\ ${VMhostName}:/tmp
    & "C:\Program Files (x86)\PuTTY\plink.exe" $VMhostUser@$VMhostName -pw $VMhostPass -m .\firmware.plink
}
