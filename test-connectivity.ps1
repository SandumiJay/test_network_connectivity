#Save the current execution policy

$currentExecutioPolicy = Get-ExecutionPolicy

#Temporarily set the execution policy to allow script execution

if($currentExecutioPolicy -eq "Restricted"){
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
    Unblock-File -Path .\Test_URLPortConnectvity.ps1
    & .\Test_URLPortConnectvity.ps1

    echo Get-ExecutionPolicy
}