MAKEFILE_DIR := $(dir $(lastword $(MAKEFILE_LIST))) 
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
	cp bash/.bashrc ~/.bashrc
endif