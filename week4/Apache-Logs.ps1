# Function Purpose is to find IP addresses that have visited the given page
# or referred from, with the given web browser, and got the given HTTP response.
# Function takes 3 variables, the page visited or referred from, HTTP code returned
# and the name of the web browser
function getIPsFromWebPage ($page, $HTTP, $webBrowser) {

# Regex declaration to find look for IP
$regex = [regex]'\b((25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|1?[0-9]{1,2})\b'

# Looks for any logs that match passed in parameters
$fullMatches = Get-Content C:\xampp\apache\logs\access.log | Select-String $page | Select-String " $HTTP " | Select-String $webBrowser

# Uses regex to find the IP Addresses and puts them into pscustomobjects to display better
$ipsUnorganized = $regex.Matches($fullMatches)
$ips = @()
for ($i=0; $i -lt $ipsUnorganized.Count; $i++){
 $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips

}

# Function is meant for Assignment "Parsing Apache Logs" which puts the logs line
# by line into a pscustomObject
function ApacheLogs1(){
$logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
$tableRecords = @()

for($i=0; $i -lt $logsNotformatted.Count; $i++){

#split a string into words
$words = $logsNotformatted[$i].split(" ");

$tableRecords += [pscustomobject]@{ "IP" = $words[0];
				    "Time" = $words[3].Trim('[');
				    "Method" = $words[5].Trim('"');
				    "Page" = $words[6];
				    "Protocol" = $words[7];
				    "Response" = $words[8];
				    "Referrer" = $words[10];
				    "Client" = $words[11..($words.Count - 1)]; }
} # end of for loop
return $tableRecords | Where-Object { $_.IP -like "10.*" }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap