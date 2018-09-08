# This sample contains no Error handling!

# Before you start, connect to vCenter Server using Connect-VIServer


# Collect hostname and password for root
$vmhost = Read-Host "Please supply a hostname"
$pwd = Read-Host -AsSecureString "Please supply root passwd"
Write-Host $pwd
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "root",$pwd


# Enable SSH on ESXi host
Get-VMHostService -VMHost $vmhost | ?{$_.Label -eq "SSH"} | Start-VMHostService

# Open ssh session to host
$SessionId = $(New-SSHSession -ComputerName $vmhost -Acceptkey -Credential $credential -ErrorAction Stop).SessionId

# If succesful, the Session Id will be received, starting with 0 for the first session
# The session Id is reference for further actions

Write-Host $SessionId

$Result = $(Invoke-SSHCommand -SessionId 0 -Command "ls").Output -split ","
$Result

# This should return the output of the ls command.

# Close SSH session
Remove-SSHSession -SessionId $SessionID
