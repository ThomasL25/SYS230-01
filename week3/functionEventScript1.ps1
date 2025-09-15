# Script file for Function and Event Logs Assignment 

# Function purpose is to find information based on shutdowns and stars in a certain time period from running
# Function takes in a single number that represents the amount of days prior should the function check for shutdowns/starts
function getShutDownRecords($days){
# Get shutdown/start records and put in variable of last 14 days
$shutdowns = Get-WinEvent -LogName System | Where-Object { $_.Id -in 1074,6006 -and ($_.TimeCreated -ge (Get-Date).AddDays(-$days)) }

# Make empty array
$shutdownsTable = @()

# Start loop to modify array
For ($i=0; $i -lt  $shutdowns.count; $i++) {

# Determine what type of event
$event = ""
if($shutdowns[$i].Id  -eq 1074) {$event=”Startup”}
if($shutdowns[$i].Id  -eq 6006) {$event=”Shutdown”}


# Add each new line with custom objects inside the array
$shutdownsTable += [pscustomobject]@{"Time" = $shutdowns[$i].TimeCreated; `
               			       "ID" = $shutdowns[$i].Id; `
                                    "Event" = $event; `
                                     "User" = "System";
                                     }
} # End of loop and display table
$shutdownsTable

} # End of Function


# Function purpose is to find information based on logins and logouts in a certain time period from running
# Function takes in a single number that represents the amount of days prior should the function check for logins
function getLoginRecords($days){
# Get login/off records and put in variable of last 14 days
$loginouts = Get-EventLog -LogName System -EntryType Information -InstanceId (7001,7002) -After (Get-Date).AddDays(-$days)

# Make empty array
$loginoutsTable = @()

# Start loop to modify array
For ($i=0; $i -lt  $loginouts.count; $i++) {

# Determine what type of event
$event = “”
if($loginouts[$i].InstanceId  -eq 7001) {$event=”Logon”}
if($loginouts[$i].InstanceId  -eq 7002) {$event=”Logoff”}

# Creating user property value
$userSID = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$user = $userSID.Translate([System.Security.Principal.NTAccount])

# Add each new line with custom objects inside the array
$loginoutsTable += [pscustomobject]@{
    Time  = $loginouts[$i].TimeGenerated
    Id    = $loginouts[$i].InstanceId
    Event = $event
    User  = $user
}
                                     
} # End of loop and display table
$loginoutsTable

} # End of Function
