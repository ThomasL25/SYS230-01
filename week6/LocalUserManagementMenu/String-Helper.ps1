<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

function checkPassword($password) {

    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $convertedPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

    if ($convertedPassword.Length -lt 6) {
        return $false
    }
    
    $hasLetter = $convertedPassword -match "[a-zA-Z]"
    $hasNumber = $convertedPassword -match "[0-9]"
    $hasSpecial = $convertedPassword -match "[^a-zA-Z0-9]"

    if ($hasLetter -and $hasNumber -and $hasSpecial) {
        return $true
    }
    else {
        return $false
    }
}