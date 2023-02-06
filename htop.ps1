# function to display system information
function Display-SystemInformation {
    # Get processor load information and select LoadPercentage
    $cpu = Get-WmiObject Win32_Processor | Select-Object LoadPercentage

    # Get operating system memory information and select FreePhysicalMemory and TotalVisibleMemorySize
    $memory = Get-WmiObject Win32_OperatingSystem | Select-Object FreePhysicalMemory, TotalVisibleMemorySize

    # Write system information to the console
    Write-Host "`n-------------------------------------------------------------------------" -ForegroundColor Yellow
    Write-Host "| CPU: $($cpu.LoadPercentage)%                                                           |" -ForegroundColor Yellow
    Write-Host "| Memory: $($memory.FreePhysicalMemory / 1024) MB / $($memory.TotalVisibleMemorySize / 1024) MB                     |" -ForegroundColor Yellow
    Write-Host "-------------------------------------------------------------------------`n" -ForegroundColor Yellow
}

# function to display process information
function Display-ProcessInformation {
    # Get all processes, sort them by CPU usage in descending order, select the top 15, and for each one
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | ForEach-Object {
        # Write process information to the console
        Write-Host "-----------------------------------------------------------" -ForegroundColor Green
        Write-Host "| $($_.ProcessName.PadRight(30))| CPU: $($_.CPU)% |" -ForegroundColor Green
    }
    # Write a message to the console
    Write-Host "--------------------------------------------------------------`n" -ForegroundColor Green
    Write-Host "Press 'Ctrl+C' to exit program." -ForegroundColor Red
}

# Clear the console
Clear-Host

# Start an infinite loop
while ($true) {
    # Write an empty line to the console
    Write-Host ""
    # Write a message to the console
    Write-Host "System Information:" -ForegroundColor Cyan
    Write-Host ""
    # Call the Display-SystemInformation function
    Display-SystemInformation
    Write-Host ""
    # Write a message to the console
    Write-Host "Process Information - Top 10 Apps:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "-------------------------------------------------" -ForegroundColor Magenta
    Write-Host "| Process Name".PadRight(30) + "| CPU Usage |" -ForegroundColor Magenta
    Write-Host "-------------------------------------------------`n" -ForegroundColor Magenta
    Write-Host ""
    # Write a message to the console
    Write-Host "Refreshing scan in 10 seconds:" -ForegroundColor Cyan
    # Call the Display-ProcessInformation function
    Display-ProcessInformation
    # Wait for 10 seconds
    Start-Sleep -Seconds 10
    # Clear the console
    Clear-Host
}
