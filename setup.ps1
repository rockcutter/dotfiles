# powershell
mkdir $HOME\Documents\PowerShell\
Copy-Item $PSScriptRoot\powershell\powershell7\Microsoft.PowerShell_profile.ps1 $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

# powershell(old)
mkdir $HOME\Documents\WindowsPowerShell\
Copy-Item $PSScriptRoot\powershell\PowerShell\Microsoft.PowerShell_profile.ps1 $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

# neovim
mkdir $HOME\AppData\Local\nvim
Copy-Item $PSScriptRoot\nvim\init.vim $HOME\AppData\Local\nvim\init.vim
