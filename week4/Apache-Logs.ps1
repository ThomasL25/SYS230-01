# Function Purpose is to find IP addresses that have visited the given page
# or referred from, with the given web browser, and got the given HTTP response.
# Function takes 3 variables, the page visited or referred from, HTTP code returned
# and the name of the web browser
function getIPsFromWebPage ($page, $HTTP, $webBrowser) {

# Regex declaration to find look for IP
$regex = [regex]'\b((25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})\b'

# Looks for any logs that match passed in parameters
$fullMatches = Get-Content access.log | Select-String $page | Select-String " $HTTP " | Select-String $webBrowser

# Uses regex to find the IP Addresses and puts them into pscustomobjects to display better
$ipsUnorganized = $regex.Matches($fullMatches)
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips

}