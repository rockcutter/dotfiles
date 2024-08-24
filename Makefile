.PHONY: setup
# winの場合のみallを置き換える
ifeq ($(OS), Windows_NT)
setup: neovim git

else
setup: bash tmux neovim git zoxide/setup

endif

.PHONY: install
install: zoxide/install

.PHONY: zoxide/install
zoxide/install:
	make -C zoxide install

.PHONY: zoxide/setup
zoxide/setup:
	make -C shell/zoxide setup

.PHONY: bash
bash: 
	make -C shell/bash setup

.PHONY: tmux
tmux:
	make -C tmux setup

.PHONY: neovim
neovim:
	make -C neovim setup

.PHONY: git
git: 
	make -C git setup

