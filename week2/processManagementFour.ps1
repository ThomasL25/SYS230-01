function navChamplain {
   $chromeOnline = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
   if ($chromeOnline) {
       Stop-Process -Name "chrome" -Force
   } else {
       Start-Process "chrome.exe" "https://www.champlain.edu"
   }
}