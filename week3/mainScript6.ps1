
. (Join-Path $PSScriptRoot 'functionEventScript1.ps1')

clear

# Get Login Records from last 21 days
getLoginRecords -days 21

# Get Shutdown records from last 21 days
getShutDownRecords -days 21
