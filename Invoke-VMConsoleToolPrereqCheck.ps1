<#
.SYNOPSIS
    This script only pulls generic information about the OS, Computer, PowerShell and PowerCLI current configuration.
    It is only meant to aid in basic troubleshooting.
.NOTES
    7/31/14     K. Kirkpatrick      Created
#>

$ExportFile = 'C:\PowerShellVersionDump.txt'

if(Test-Path $ExportFile){Remove-Item $ExportFile -Force}

$ErrorActionPreference = 'SilentlyContinue'

Write-Output "===== PowerCLI Version Information =============================" | Out-File $ExportFile -Append
if ((Get-PSSnapin -Registered | Where Name -eq 'VMware.VimAutomation.Cores') -eq $null) {
    Write-Output "PowerCLI Does not look to be installed" | Out-File $ExportFile -Append
    Write-Output " " | Out-File $ExportFile -Append
} else {
    Add-PSSnapin vmware.vimautomation.core
    Get-PowerCLIVersion | Out-File $ExportFile -Append
}

Write-Output "===== PowerShell Version Information =============================" | Out-File $ExportFile -Append
$PSVersionTable | Out-File $ExportFile -Append

Write-Output "===== OS Details =============================" | Out-File $ExportFile -Append
$OSDetail = gwmi win32_operatingsystem | Select caption,csdversion,osarchitecture
$CompDetail = gwmi win32_computersystem | Select Manufacturer,Model,numberofprocessors,numberoflogicalprocessors
Write-Output "Manufacturer: $($CompDetail.Manufacturer)" | Out-File $ExportFile -Append
Write-Output "Model: $($CompDetail.Model)" | Out-File $ExportFile -Append
Write-Output "Physical Procs: $($CompDetail.numberofprocessors)" | Out-File $ExportFile -Append
Write-Output "Logical Procs: $($CompDetail.numberoflogicalprocessors)" | Out-File $ExportFile -Append
Write-Output "OS: $($OSDetail.caption)" | Out-File $ExportFile -Append
Write-Output "Service Pack: $($OSDetail.csdversion)" | Out-File $ExportFile -Append
Write-Output "OS Architecture: $($OSDetail.osarchitecture)" | Out-File $ExportFile -Append