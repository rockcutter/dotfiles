COPY_CMD := cp

ifeq ($(OS), Windows_NT)
	SHELL := pwsh.exe
endif

ifeq ($(OS), Windows_NT)
	COPY_CMD := cp
endif

.PHONY: nvimrc shellprofile git

all: nvimrc shellprofile git

nvimrc:
ifeq ($(OS), Windows_NT)
	Copy-Item -Path nvim -Destination $${HOME}/AppData/Local -Recurse -Force
else
	cp -r nvim $${HOME}/.config
endif

nvimrc/update:
ifeq ($(OS), Windows_NT)
	cp "~\AppData\Local\nvim\init.lua" "nvim\init.lua"
else
	cp -r $${HOME}/.config/nvim .
endif


shellprofile:
ifeq ($(OS), Windows_NT)
	cp "powershell\powershell7\Microsoft.PowerShell_profile.ps1" "~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
	cp "powershell\PowerShell\Microsoft.PowerShell_profile.ps1" "~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
else
	curl -o ~/.git-prompt.sh -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
	cp bash/.bashrc ~/.bashrc
endif

git:;
ifeq ($(OS), Windows_NT)
	Copy-Item -Path git/.gitconfig -Destination $${HOME}/.gitconfig -Force
else
	cp git/.gitconfig ~/.gitconfig
endif
