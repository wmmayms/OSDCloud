Write-Host  -ForegroundColor Cyan "Starting OSD process"
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Cyan "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#Make sure I have the latest OSD Content
Write-Host  -ForegroundColor Cyan "Updating OSD PowerShell Module"
Install-Module OSD -Force

Write-Host  -ForegroundColor Cyan "Importing OSD PowerShell Module"
Import-Module OSD -Force

#Eject ISO
Write-Host  -ForegroundColor Cyan "Ejecting ISO"
$DeviceID = (Get-CimInstance Win32_LogicalDisk | ?{ $_.DriveType -eq 5}).DeviceID
(new-object -COM Shell.Application).NameSpace(17).ParseName($DeviceID).InvokeVerb('Eject')
Start-Sleep -Seconds 5

#Start OSDCloud ZTI the RIGHT way
Write-Host  -ForegroundColor Cyan "Start OSDCloud with MY Parameters"
Start-OSDCloud -OSLanguage en-us -OSBuild 20H2 -OSEdition Enterprise -ZTI

#Anything I want  can go right here and I can change it at any time since it is in the Cloud!!!!!
Write-Host  -ForegroundColor Cyan "Starting OSDCloud PostAction ..."
Write-Warning "I'm not sure of what to put here yet"

#Restart from WinPE
Write-Host  -ForegroundColor Cyan "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot
