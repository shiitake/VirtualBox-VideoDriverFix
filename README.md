# VirtualBox-VideoDriverFix
These scripts disable and enable the Virtual Box Display drivers whenever you have a display failure.

There seems to a somewhat persistent problem with the Virtual Box Guest Additions display driver when running a Windows 10 guest. I have personally experienced this when using a multple monitor display.

### Requirements: 
* Windows 10
* PowerShell Device Management Module 1.0.2 - https://devicemanagement.codeplex.com/
* Local admin permissions

You will want to unzip the Device Management Module in a directory that will be accessable to the script. 

Setup the task very similar to the one on the other repo. The particular error that you will want to trigger on is as follows: 
* Log: System
* Source: Display
* Event ID: 4113

These scripts are steps are very similar to the ones discussed in [https://github.com/shiitake/Chrome-Vs-Group-Policy]. Essentially you need to create a scheduled task to trigger when the display error occurs. The task will run the visual basic script which will run the powershell script.

Here's what the VB script looks like: 

```vb.net
Dim objShell,objFSO,objFile
Set objShell=CreateObject("WScript.Shell")
Set objFSO=CreateObject("Scripting.FileSystemObject")
 
'enter the path for your PowerShell Script
strPath="C:\Users\shiitake\Documents\MyPath\Scripts\fix_display.ps1"
 
If objFSO.FileExists(strPath) Then
'return short path name
set objFile=objFSO.GetFile(strPath)
strCMD="powershell -nologo -command" & Chr(34) & "&{" &_
objFile.ShortPath & "}" & Chr(34)
 
'Uncomment next line for debugging
'WScript.Echo strCMD
 
'use 0 to hide window
objShell.Run strCMD,0
Else
 
'Display error message
WScript.Echo "Failed to find " & strPath
WScript.Quit
End If
```

Here is the PowerShell script that will run. Make sure that the Import-Module path points to the download location for the device management module that you've downloaded. Also you may need to confirm that the InstanceId is correct for your display adapter. You can find that looking in the Device Manager in windows under Display Adapters > VirtualBox Graphics Adapter for Windows 8 > Properties > Details tab > Device instance path. 

```PowerShell
Set-ExecutionPolicy -Scope process Bypass

Import-Module C:\Users\shiitake\Documents\MyPath\DeviceManagement\Devicemanagement.psd1

Get-Device | Where-Object -Property InstanceId -eq "PCI\VEN_80EE&DEV_BEEF&SUBSYS_00000000&REV_00\3&267A616A&1&10" | Disable-Device -Confirm:$false

Get-Device | Where-Object -Property InstanceId -eq "PCI\VEN_80EE&DEV_BEEF&SUBSYS_00000000&REV_00\3&267A616A&1&10" | Enable-Device -Confirm:$false
```
