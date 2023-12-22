COPY_CMD := cp

ifeq ($(OS), Windows_NT)
	COPY_CMD := cp
endif

.PHONY: nvimrc shellprofile git

echo: 
	echo $(VIMRC_PATH)

all: nvimrc shellprofile git

nvimrc:
ifeq ($(OS), Windows_NT)
	cp "nvim\init.lua" "~\AppData\Local\nvim\init.lua"
	cp "nvim\lua" "~\AppData\Local\nvim\lua"
else
	mkdir -p ~/.config/nvim
	cp nvim/init.lua ~/.config/nvim/init.lua
	cp -r nvim/lua ~/.config/nvim/lua
endif

nvimrc/update:
ifeq ($(OS), Windows_NT)
	cp "~\AppData\Local\nvim\init.lua" "nvim\init.lua"
else
	mkdir -p nvim
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
	cp git/.gitconfig ~/.gitconfig
