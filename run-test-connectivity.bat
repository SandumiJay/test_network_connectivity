@@echp off

:: change the directory where powershell saved

cd /d "powershell\app-conn"

::Run Powershell Script with elevated privilages

Powershell.exe -executionpolicy remotesigned -Test_URLPortConnectivity.ps1