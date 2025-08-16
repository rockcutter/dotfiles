
help: 
	less Makefile

setup: 
	-make -C ./zsh setup
	-make -C ./tmux setup
	-make -C ./neovim setup
	-make -C ./git setup
	-make -C ./wezterm -f linux.mk setup
	# deprecated 
	-make -C ./alacritty -f linux.mk setup
