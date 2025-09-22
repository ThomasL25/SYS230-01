. (Join-Path $PSScriptRoot 'Apache-Logs.ps1')

clear

# Check IPs for 404 errors
getIPsFromWebPage -page friend.html -HTTP 404 -webBrowser Mozilla