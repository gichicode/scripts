param (
    [Parameter(Mandatory = $true)]
    [string]$ProcessPath
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if ([string]::IsNullOrWhiteSpace($ProcessPath)) {
    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] ERROR: ProcessPath argument is null or empty."
    exit 1
}

Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Received ProcessPath argument: $ProcessPath"

function Restart-ProcessWithDelay {
    param (
        [string]$Path
    )

    $procBase = [System.IO.Path]::GetFileNameWithoutExtension($Path)
    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Attempting to stop process [$procBase]..."

    if (![string]::IsNullOrWhiteSpace($procBase)) {
        $processes = Get-Process -Name $procBase -ErrorAction SilentlyContinue
        if ($processes) {
            foreach ($proc in $processes) {
                try {
                    $proc.Kill()
                    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Terminated process ID [$($proc.Id)]."
                } catch {
                    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Failed to terminate process: $_"
                }
            }
        } else {
            Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Target process not found."
        }

        Start-Sleep -Seconds 60

        Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Starting process [$procBase]..."
        try {
            Start-Process -FilePath $Path
            Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Process started successfully."
        } catch {
            Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Failed to start process: $_"
        }
    } else {
        Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Failed to extract process name from path."
    }
}

Restart-ProcessWithDelay -Path $ProcessPath
