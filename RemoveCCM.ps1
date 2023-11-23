#set up logging
$log_Path = "C:\Temp\RIP_SCCM_"
$log_Date = (Get-Date -Format 'MM-dd-yyyy') + ".log"
$log_Path + $log_Date

$VerbosePreference = "Continue"

Start-Transcript -Path $log_Path + $log_Date -Append -Force
#kill all ccm services
if ((Get-Service smstsmgr -ErrorAction SilentlyContinue) -ne $null) {Get-Process dwrcc | Stop-Process -ErrorAction Continue -Force -Verbose | Out-Host}
if ((Get-Service CcmExec -ErrorAction SilentlyContinue) -ne $null) {Get-Process dwrcc | Stop-Process -ErrorAction Continue -Force -Verbose | Out-Host} 
#CCM folders
$Folders = @(
    "C:\Windows\ccm"
    "C:\Windows\ccmsetup"
    "C:\Windows\ccmcache"
)
foreach ($f in $Folders) {
    Write-Host "Removing $f"
    Remove-Item -Path $f -Recurse -Force -Confirm:$false -ErrorAction Continue -Verbose | Out-Host
    if ($? -eq $true) {Write-Host "$F removed."}
    else {Write-Error "$F not found or an error has occurred."}
}

$Files = @(
    "C:\Windows\SMSCFG.INI"
    "C:\Windows\sms*.mif"
)
foreach ($f in $files) {
    Write-Host "Removing $f"
    Remove-Item -Path $i -Force -Confirm:$false -ErrorAction Continue -Verbose | Out-Host
    if ($? -eq $true) {Write-Host "$F removed."}
    else {Write-Error "$F not found or an error has occurred."}
}
$keys = @(
"HKLM:\SOFTWARE\Microsoft\ccm"
"HKLM:\SOFTWARE\Microsoft\CCMSETUP"
"HKLM:\SOFTWARE\Microsoft\SMS"
)

foreach ($k in $keys) {
    Write-Host "Removing $k"
Remove-Item $k -Force -Confirm:$false -ErrorAction Continue -Verbose | Out-Host
if ($? -eq $true) {Write-Host "$k removed."}
else {Write-Error "$k not found or an error has occurred."}
}

Get-WmiObject -query "Select * From __Namespace Where Name='CCM'" -Namespace "root" | Remove-WmiObject -Verbose | Out-Host
Get-WmiObject -query "Select * From __Namespace Where Name='sms'" -Namespace "root\cimv2" | Remove-WmiObject -Verbose | Out-Host

Write-Host "Removed SCCM. Stopping Script."
Stop-Transcript