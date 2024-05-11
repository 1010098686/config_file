Invoke-Expression (&starship init powershell)

set-alias vim nvim

Set-Alias lvim 'C:\Users\f00613555\.local\bin\lvim.ps1'

Set-Alias notepad Notepad--

$env:httpproxy=""

$env:httpsproxy=""

[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()

[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

#34de4b3d-13a8-4540-b76d-b9e8d3851756 PowerToys CommandNotFound module

Import-Module "C:\Program Files\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"
#34de4b3d-13a8-4540-b76d-b9e8d3851756
