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

$execute = CheckExecute
if($execute){
	mkdir $HOME\Documents\PowerShell\
	Copy-Item $PSScriptRoot\powershell\powershell7\Microsoft.PowerShell_profile.ps1 $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
}

$execute = CheckExecute
# powershell(old)
if($execute){
	mkdir $HOME\Documents\WindowsPowerShell\
	Copy-Item $PSScriptRoot\powershell\PowerShell\Microsoft.PowerShell_profile.ps1 $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

$execute = CheckExecute
# neovim
if($execute){
	mkdir $HOME\AppData\Local\nvim
	Copy-Item $PSScriptRoot\nvim\init.vim $HOME\AppData\Local\nvim\init.vim
}
