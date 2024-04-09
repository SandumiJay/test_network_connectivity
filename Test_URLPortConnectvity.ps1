$csv_path = ".\network-troubleshoot.csv"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputfileName = ".\connectivity_output_$timestamp.csv"

# Read CSV
Import-Csv -Path $csv_path | ForEach-Object {
    $address = $_.URL
    $port = $_.Port

    try {
        $connectivity = Test-NetConnection -ComputerName $address -Port $port -ErrorAction Stop
        $pingSucceed = $connectivity.PingSucceeded
        $portSucceed = $connectivity.TcpTestSucceeded
        $errorMessage = $connectivity.Exception.Message
    }
    catch {
        $pingSucceed = $false
        $portSucceed = $false
        $errorMessage = $_.Exception.Message
    }

    $result = [PSCustomObject]@{
        URL = $address
        Port = $port
        PingSucceed = $pingSucceed
        PortSucceed = $portSucceed
        ErrorMessage = $errorMessage
    }

    $result | Export-Csv -Path $outputfileName -Append -NoTypeInformation
}
