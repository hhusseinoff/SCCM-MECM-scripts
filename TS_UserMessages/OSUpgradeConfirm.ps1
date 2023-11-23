$OS = "Windows 10 22H2 Enterprise, (10.0.19045.x)"

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

$MsgTitle = "Confirm"

$MsgBody = "This sequence will upgrade the machine's operating system to $OS.`n`nYou will be logged off and the machine will be put in Maintenance mode after restarting.`n`nThis will prevent you or others from accessing the machine until the upgrade is finished in up to 2 hours.`n`nLocally stored data will be retained.`n`nClicking the No button now, will allow you to go back and no changes will be performed until you click on the Install button for this task sequence in Software Center again.`n`nDo you wish to proceed?"

$Result = [System.Windows.MessageBox]::Show($MsgBody,$MsgTitle,"YesNo","Question")

$ResultString = $Result.ToString()

return $ResultString