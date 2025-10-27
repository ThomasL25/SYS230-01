$configPath = "C:\Users\champuser\SYS230-01\week7\configuration.txt"

function readConfiguration {
    $lines = Get-Content $configPath
    
    $config = [PSCustomObject]@{
        Days = $lines[0]
        ExecutionTime = $lines[1]
    }
    return $config
}

function changeConfiguration () {
    $validDays = $false
    while (-not $validDays) {
        $days = Read-Host "Enter number of days (digits only)"
        if ($days -match '^\d+$') {
            $validDays = $true
        } else {
            Write-Host "Invalid input. Please enter digits only."
        }
    }
    
    $validTime = $false
    while (-not $validTime) {
        $time = Read-Host "Enter execution time (format: d:dd AM/PM)"
        if ($time -match '^\d:\d{2} (AM|PM)$') {
            $validTime = $true
        } else {
            Write-Host "Invalid input. Please use format: d:dd AM/PM"
        }
    }
    
    Set-Content -Path $configPath -Value @($days, $time)
    Write-Host "Configuration updated successfully."
}

function configurationMenu() {

   $Prompt = "`n"
   $Prompt += "Please choose your operation:`n"
   $Prompt += "1 - Show Configuration`n"
   $Prompt += "2 - Change Configuration`n"
   $Prompt += "3 - Exit`n"

   $operation = $true

   while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $config = readConfiguration
        $config | Format-List
    }

    elseif($choice -eq 2){
        changeConfiguration
    }

    else {
        Write-Host "Invalid choice."
    }
  }
}

clear
