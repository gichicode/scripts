param (
    [string]$ServiceName
)

function Restart-ServiceWithDelay {
    param (
        [string]$Name
    )

    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] サービス [$Name] を停止中..."

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue
    if ($service -and $service.Status -eq 'Running') {
        Stop-Service -Name $Name -Force
        Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] 停止要求を送信しました。"
    } else {
        Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] サービスはすでに停止しています。"
    }

    Start-Sleep -Seconds 90

    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] サービス [$Name] を起動中..."
    Start-Service -Name $Name
    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] 起動しました。"
}

Restart-ServiceWithDelay -Name $ServiceName
