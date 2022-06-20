#powershell
mkdir $HOME\Documents\PowerShell\
cp powershell\Microsoft.PowerShell_profile.ps1 $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

#neovim
mkdir $HOME\AppData\Local\nvim
cp nvim\init.vim $HOME\AppData\Local\nvim\init.vim
