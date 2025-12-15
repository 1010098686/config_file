# 配置文件符号链接映射
$config = @{
	"$HOME/.config/Microsoft.PowerShell_profile.ps1" = "$HOME/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
	"$HOME/.config/Microsoft.PowerShell_profile.ps1" = "$HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
	"$HOME/.config/.wezterm.lua" = "$HOME/.wezterm.lua"
	"$HOME/.config/settings.json" = "$HOME/AppData/Roaming/Code/User/settings.json"
}

foreach ($entry in $config.GetEnumerator()) {
	$source_file = $entry.Key
	$link_file = $entry.Value
	
	if (-not (Test-Path $source_file)) {
		Write-Warning "$source_file not exists"
		continue
	}

	# 创建目录
	$link_dir = Split-Path $link_file -Parent
	if (-not (Test-Path $link_dir)) {
		New-Item -ItemType Directory -Path $link_dir -Force | Out-Null
	}

	# 备份已存在文件
	if (Test-Path $link_file) {
		$backup_file = "$link_file.bak_$(Get-Date -Format 'yyyyMMddHHmmss')"
		Rename-Item -Path $link_file -NewName $backup_file -Force
		Write-Host "backup $link_file to $backup_file"
	}

	# 创建符号链接
	try {
		New-Item -ItemType SymbolicLink -Path $link_file -Target $source_file -Force
		Write-Host "create link $link_file => $source_file"
	} catch {
		Write-Error "create link fail: $_"
	}
}

# 程序安装
winget install --id Starship.Starship --source winget
Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -AllowPrerelease -Force
Install-Module -Name Terminal-Icons -Repository PSGallery
winget install eza-community.eza --source winget
choco install zoxide
winget install fzf --source winget
winget install sharkdp.bat --source winget
