# powershell

Function CheckExecute(){
	while($True){
		$input = Read-Host "実行しますか?(y/n)"
		if($input -eq "y"){
			return $True
		} 
		if($input -eq "n"){
			return $False
		}
	}
}

# powershell
$configCurrentPath = "$PSScriptRoot\powershell\powershell7\Microsoft.PowerShell_profile.ps1"
$configCopyDest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$configCopyDestDir = Split-Path -Parent $configCopyDest

Write-Host "$configCopyDestDir を作成し、$configCurrentPath を$configCopyDest にコピーします"
$execute = CheckExecute
if($execute){
	mkdir $configCopyDestDir 
	Copy-Item $configCurrentPath $configCopyDest
}


# powershell(old)
$configCurrentPath = "$PSScriptRoot\powershell\PowerShell\Microsoft.PowerShell_profile.ps1"
$configCopyDest = "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
$configCopyDestDir = Split-Path -Parent $configCopyDest

Write-Host "$configCopyDestDir を作成し、$configCurrentPath を$configCopyDest にコピーします"
$execute = CheckExecute
if($execute){
	mkdir $configCopyDestDir 
	Copy-Item $configCurrentPath $configCopyDest
}


# vim
$configCurrentPath = "$PSScriptRoot\nvim\init.vim"
$configCopyDest = "$HOME\AppData\Local\nvim\init.vim"
$configCopyDestDir = Split-Path -Parent $configCopyDest

Write-Host "$configCopyDestDir を作成し、$configCurrentPath を$configCopyDest にコピーします"
$execute = CheckExecute
if($execute){
	mkdir $configCopyDestDir 
	Copy-Item $configCurrentPath $configCopyDest
}

