
. (Join-Path $PSScriptRoot 'Apache-Logs.ps1')

clear

# Parse the Apache Logs
ApacheLogs1

# Check IPs for 404 errors
getIPsFromWebPage -page friend.html -HTTP 404 -webBrowser Mozilla

