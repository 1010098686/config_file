Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell --hook prompt | Out-String) })

set-alias notepad Notepad--
set-alias vim nvim

Function eza_ll { eza --icons=auto }
Set-Alias -Name ll -Value eza_ll

Function fzf_preview {fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"}
Set-Alias -Name fzfp -Value fzf_preview

function which_command($command) {
    Get-Command $command | Select-Object -ExpandProperty Source
}
Set-Alias -Name which -Value which_command


$env:httpproxy="http://f00613555:%40%40Fk950803@proxy.huawei.com:8080"

$env:httpsproxy="http://f00613555:%40%40Fk950803@proxy.huawei.com:8080"

$env:no_proxy="127.0.0.1,localhost,mirrors.tools.huawei.com,mirrors.myhuaweicloud.com"

[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()

[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

Import-Module PSReadLine
Import-Module -Name Terminal-Icons

# 设置预测文本来源为历史记录
Set-PSReadLineOption -PredictionSource History

# 每次回溯输入历史，光标定位于输入内容末尾
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

Set-PSReadLineOption -PredictionViewStyle ListView

# 设置 Tab 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key "Tab" -Function MenuComplete

# 设置 Ctrl+d 为退出 PowerShell
Set-PSReadlineKeyHandler -Key "Ctrl+d" -Function ViExit

# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

# 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward


function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
