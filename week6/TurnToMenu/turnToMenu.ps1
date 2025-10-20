. (Join-Path $PSScriptRoot ..\LocalUserManagementMenu\String-Helper.ps1)
. (Join-Path $PSScriptRoot ..\LocalUserManagementMenu\Event-Logs.ps1)
. (Join-Path $PSScriptRoot ..\..\week2\processManagementFour.ps1)
. (Join-Path $PSScriptRoot ..\..\week4\Apache-Logs.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu - if no instances of Chrome is running`n"
$Prompt += "5 - Exit`n"


$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $tableRecords = ApacheLogs1 | Select-Object -Last 10
	$tableRecords | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 2){
        $failedLogins = getFailedLogins 360 | Select-Object -Last 10
	$failedLogins | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 3){
	$failedLogins = getFailedLogins 360
	$atRiskUsers = $failedLogins | Group-Object -Property User | Where-Object { $_.Count -gt 10 }
	$atRiskUsers | Select-Object Name, Count | Format-Table -AutoSize -Wrap
    }

    elseif($choice -eq 4){
        navChamplain
    }

    else {
	Write-Host "Invalid choice" | Out-String
    }

}