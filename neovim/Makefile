setup:
ifeq ($(OS), Windows_NT)
	Copy-Item -Path nvim -Destination $${HOME}/AppData/Local/nvim -Recurse -Force
else
	rm -rf $${HOME}/.config/nvim
	cp -r nvim $${HOME}/.config/nvim
endif

