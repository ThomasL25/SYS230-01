. (Join-Path $PSScriptRoot Email.ps1)
. (Join-Path $PSScriptRoot Scheduler.ps1)
. (Join-Path $PSScriptRoot Configuration.ps1)
. (Join-Path $PSScriptRoot ..\week6\LocalUserManagementMenu\Event-Logs.ps1)

# Obtaining Config
$configuration = readConfiguration

# Obtaining at risk users
$Failed = atRiskUsers $configuration.Days

# Sending at risk users as email
if ($Failed) {
    $emailBody = $Failed | Select-Object Name, Count | Format-Table | Out-string
} else {
    $emailBody = [PSCustomObject]@{Name = "N/A"; Count = 0} | Format-Table | Out-string
}
SendAlertEmail $emailBody

# Setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)