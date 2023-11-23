##For 32-bit apps:


$RegExists = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{31884EF8-7A0B-4848-8EF5-8F7F0F6BA714}" -ErrorAction SilentlyContinue

if($null -eq $RegExists)
{
    Write-Host "Installed"
}



##For 64-bit Apps::

$RegExists = Get-ItemProperty -Path "HKLM:\SOFTWARE \Microsoft\Windows\CurrentVersion\Uninstall\{31884EF8-7A0B-4848-8EF5-8F7F0F6BA714}" -ErrorAction SilentlyContinue

if($null -eq $RegExists)
{
    Write-Host "Installed"
}


##Where you of course replace the MSI GUID to match what the application’s.
