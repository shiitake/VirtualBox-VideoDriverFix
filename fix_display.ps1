Set-ExecutionPolicy -Scope process Bypass

Import-Module C:\Users\shiitake\Documents\MyPath\DeviceManagement\Devicemanagement.psd1

Get-Device | Where-Object -Property InstanceId -eq "PCI\VEN_80EE&DEV_BEEF&SUBSYS_00000000&REV_00\3&267A616A&1&10" | Disable-Device -Confirm:$false

Get-Device | Where-Object -Property InstanceId -eq "PCI\VEN_80EE&DEV_BEEF&SUBSYS_00000000&REV_00\3&267A616A&1&10" | Enable-Device -Confirm:$false