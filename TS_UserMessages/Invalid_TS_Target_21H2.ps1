$IntendedOS = "Windows 10 21H2 Enterprise, (10.0.19044.x)"

try
{
    $TSProgressUI = New-Object -ComObject Microsoft.SMS.TSProgressUI
    $TSProgressUI.CloseProgressDialog()
}
Catch
{
    $ReturnString = "Error"

    return $ReturnString

    exit 0
}

Add-Type -AssemblyName PresentationCore,PresentationFramework

$CurrentWinDisplayVersion = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "DisplayVersion" -ErrorAction SilentlyContinue

$CurrentWinEdition = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "EditionID" -ErrorAction SilentlyContinue

$CurrentWinBuild = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "CurrentBuild" -ErrorAction SilentlyContinue

$CurrentWinUBR = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name "UBR" -ErrorAction SilentlyContinue

$CurrentOSString = "Windows 10 $CurrentWinDisplayVersion $CurrentWinEdition" + " (" + "10.0." + "$CurrentWinBuild" + "." + "$CurrentWinUBR" + ")"

$MsgTitle = "Invalid Task Sequence Target Device"

$MsgBody = "The sequence you're attempting to run is intended for machines on $IntendedOS`n`nThis machine is currently running on $CurrentOSString.`n`nSequence will not run."

$Result = [System.Windows.MessageBox]::Show($MsgBody,$MsgTitle,"OK","Hand")

$ResultString = $Result.ToString()

return $ResultString