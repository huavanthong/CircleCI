$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$command = "go test -v ./..."

$commandOutput = Invoke-Expression $command

# $commandOutput -split "`n" | ForEach-Object { Write-Host $_ }

$commandOutput | ForEach-Object { "$timestamp $_" } | Out-Host 

Write-Host $commandOutput 

# go test -v ./... | ForEach-Object { Write-Host $_ } | Out-File -FilePath console_log.txt


# Invoke-Expression $command| Tee-Object -FilePath console_log.txt
# $exitCode = $LASTEXITCODE

# if ($exitCode -ne 0) {
#     Write-Host "Command executed successfully"
# }