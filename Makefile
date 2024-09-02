.PHONY: setup
# winの場合のみsetupを置き換える
ifeq ($(OS), Windows_NT)
setup: neovim git

else
setup: bash tmux neovim git zoxide zsh opencommit

endif



.PHONY: install
install: zoxide/install

.PHONY: zoxide/install
zoxide/install:
	make -C zoxide install

.PHONY: opencommit
opencommit: 
	make -C opencommit setup

.PHONY: zoxide
zoxide:
	make -C shell/zoxide setup

.PHONY: bash
bash: 
	make -C shell/bash setup

.PHONY: zsh
zsh: 
	make -C shell/zsh setup

.PHONY: tmux
tmux:
	make -C tmux setup

.PHONY: neovim
neovim:
	make -C neovim setup

.PHONY: git
git: 
	make -C git setup

