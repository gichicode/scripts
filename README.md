# PowerShell Restart Scripts

このリポジトリには、Windows 上でサービスまたは exe プロセスを一時停止し、一定時間後に再起動する PowerShell スクリプトが含まれています。主に **Windows タスクスケジューラ**による自動実行を想定しています。

---

## 📄 スクリプト一覧

### 1. Restart-ServiceWithDelay.ps1

指定したサービスを停止し、**90秒後に再起動**します。

#### 使用方法

当該スクリプトを "C:\Scripts\" に置いた場合

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Scripts\Restart-ServiceWithDelay.ps1" -ServiceName "YourServiceName"
```
パラメータ
-ServiceName : 再起動対象のサービス名

### 2. Restart-ProcessWithDelay.ps1
指定した exe プロセスを停止し、**60秒後に再起動**します。

#### 使用方法

当該スクリプトを "C:\Scripts\" に置いた場合

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Scripts\Restart-ProcessWithDelay.ps1" -ProcessPath "C:\Path\To\YourApp.exe"
```
パラメータ
-ProcessPath : 再起動対象の exe ファイルのフルパス（例：C:\Program Files\MyApp\MyService.exe）

## 🕒 タスクスケジューラを使用してスクリプトを実行する手順

当該スクリプトを "C:\Scripts\" に置いた場合

1. タスクスケジューラを開く
    - Windows のスタートメニューを開き、「タスクスケジューラ」と入力して、アプリケーションを開きます。

2. 新しいタスクを作成する
    - タスクスケジューラの右側にある「アクション」パネルで、「タスクの作成...」をクリックします。

3. タスクの基本情報を設定する
    - 「全般」タブで、タスクに名前（例：RestartProcess）を付け、説明を入力します。
    - 「最上位の特権で実行する」にチェックを入れると、管理者権限で実行できます（必要な場合）。

4. トリガーの設定
    - 「トリガー」タブを選択し、[新規] ボタンをクリックして、新しいトリガーを作成します。
    - トリガーの種類（時間、イベントなど）を設定し、実行するタイミングを決めます（例：毎日、特定の時刻など）。

5. アクションの設定

    - 「アクション」タブで、[新規] ボタンをクリックし、以下の設定を行います。
        - アクション: 「プログラムの開始」
        - プログラム/スクリプト: powershell.exe
        - 引数の追加: 以下を入力します（スクリプトと引数を指定）:
            1. サービス再起動用
                ```powershell
                -ExecutionPolicy Bypass -File "C:\Scripts\Restart-ServiceWithDelay.ps1" -ServiceName "YourServiceName"
                ```
            1. exe プロセス再起動用
                ```powershell
                -ExecutionPolicy Bypass -File "C:\Scripts\Restart-ProcessWithDelay.ps1" -ProcessPath "C:\Path\To\YourProgram.exe"
                ```

6. 条件の設定（任意）
    - 「条件」タブで、タスクが実行される条件を指定できます。例えば、「AC電源に接続している場合のみ実行」などです。

7. 設定の確認と保存
    - 「設定」タブで、タスクの実行方法に関するオプションを確認します。例えば、「失敗した場合に再試行する」などを設定できます。
    - 設定が完了したら、「OK」をクリックしてタスクを保存します。

8. タスクの実行確認
    - タスクスケジューラで作成したタスクを右クリックし、「実行」を選択して手動で実行できます。
    - スクリプトが正常に動作することを確認します。

## ⚠️ 注意点

- .ps1 ファイルは管理者権限での実行を推奨します
- スクリプトが動作しない場合は、次の点をご確認ください：
    - ExecutionPolicy の制限
    - スクリプトパスやサービス名、exe パスの記述ミス

## 🔧 カスタマイズ例

遅延時間（デフォルト：90秒）を変更するには、スクリプト内の Start-Sleep -Seconds 90 の数値を調整してください

## 👤 Author

This script was created by gichico to automate periodic service and process restarts for improved system stability.
