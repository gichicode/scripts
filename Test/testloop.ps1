# ログファイルのパスを設定
$logFile = "C:\Scripts\Test\testloop_log.txt"

# ログを開始
Start-Transcript -Path $logFile

# ここから、実行する内容を記述
Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Script has started."

# 無限ループ（テストのための例）
while ($true) {
    Write-Output "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] Running test loop..."
    Start-Sleep -Seconds 5
}

# ログを終了
Stop-Transcript
