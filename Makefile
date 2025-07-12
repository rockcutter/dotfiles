
help: 
	less Makefile

setup: 
	-make -C ./zsh setup
	-make -C ./tmux setup
	-make -C ./neovim setup
	-make -C ./git setup
	-make -f ./alacritty/linux.mk setup
