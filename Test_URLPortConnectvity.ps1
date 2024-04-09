
$csv_path = ".\network-troubleshoot.csv"

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

$outputfileName="\connectivity_output_$timestamp.csv"

# echo "Read CSV"

$path = Import-Csv -Path $csv_path | ForEach-Object {
    $address=$_.URL
    $port= $_.Port
    $connectivity = Test-NetConnection -ComputerName $address -port $port

    $result = [PSCustomObject]@{
        URL=$address
        Port=$port
        PingSucceed= $connectivity.PingSucceeed
        PortSucceed= $connectivity.TcpTestSucceed
    }

    $result | Export-Csv -Path $outputfileName -Append -NoTypeInformation

    if($address -eq $null){
        break
    }

}