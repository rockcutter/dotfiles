
.PHONY: all
# winの場合のみallを置き換える
ifeq ($(OS), Windows_NT)
all: neovim git

else
all: bash tmux neovim git

endif

.PHONY: bash
bash: 
	make -C shell/bash sync

.PHONY: tmux
tmux:
	make -C tmux sync

.PHONY: neovim
neovim:
	make -C neovim sync

.PHONY: git
git: 
	make -C git sync
