ifeq ($(OS), Windows_NT)
	SHELL := pwsh.exe
endif

.PHONY: nvimrc shellprofile

all: nvimrc shellprofile

nvimrc:;
ifeq ($(OS), Windows_NT)
	cp "nvim\init.vim" "~\AppData\Local\nvim\init.vim"
else
	mkdir -p ~/.config/nvim
	cp nvim/init.vim ~/.config/nvim/init.vim
endif

shellprofile:;
ifeq ($(OS), Windows_NT)
	cp "powershell\powershell7\Microsoft.PowerShell_profile.ps1" "~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
	cp "powershell\PowerShell\Microsoft.PowerShell_profile.ps1" "~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
else
	curl -o .git-prompt.sh -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	cp bash/.bashrc ~/.bashrc
endif
