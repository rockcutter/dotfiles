.PHONY: setup
# winの場合のみsetupを置き換える
ifeq ($(OS), Windows_NT)
setup: neovim git

else
setup: bash tmux neovim git zoxide zsh opencommit 

endif


.PHONY: install
ifeq ($(OS), Windows_NT)
install: 

else
install: zoxide/install opencommit/install git/install

endif

.PHONY: zoxide/install
zoxide/install:
	make -C zoxide install

.PHONY: opencommit/install
opencommit/install:
	# make -C opencommit install

.PHONY: opencommit
opencommit: 
	# make -C opencommit setup

.PHONY: zoxide
zoxide:
	make -C shell/zoxide setup

.PHONY: bash
bash: 
	make -C shell/bash setup

.PHONY: zsh
zsh: 


.PHONY: tmux
tmux:
	make -C tmux setup

.PHONY: neovim
neovim:
	make -C neovim setup

.PHONY: git
git: 
	make -C git setup

.PHONY: git/install
git/install: 
	make -C git install
