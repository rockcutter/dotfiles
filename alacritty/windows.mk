.PHONY: setup

setup:
	-mkdir -p "$$HOME/AppData/Roaming/alacritty"
	cp alacritty.toml "$$HOME/AppData/Roaming/alacritty/"
