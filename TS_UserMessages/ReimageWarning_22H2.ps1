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

$MsgTitle = "Reimage Warning"

$MsgBody = "This Task sequence is intended to rebuild your machine from scratch using $OS.`n`nAny locally stored data, such as in C:\Temp will be DELETED, unless backed up elsewhere, for example in the cloud (OneDrive).`n`nDo you wish to proceed?"

$Result = [System.Windows.MessageBox]::Show($MsgBody,$MsgTitle,"YesNo","Warning")

$ResultString = $Result.ToString()

if("Yes" -eq $Result)
{
    $MsgTitle2 = "Information"

    $MsgBody2 = "The machine will be restarted and Maintenance mode will be enabled.`n`nThis will prevent you or others from accessing the machine until the rebuild is finished in up to 4 hours.`n`nClicking the Cancel button now, will allow you to go back and no changes will be performed until you click on the (Re)Install button for this task sequence in Software Center again."

    $Result2 = [System.Windows.MessageBox]::Show($MsgBody2,$MsgTitle2,"OKCancel","Asterisk")

    $ResultString2 = $Result2.ToString()

    return $ResultString2
}
else
{
    return $ResultString
}