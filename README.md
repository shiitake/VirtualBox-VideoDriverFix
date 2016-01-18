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
