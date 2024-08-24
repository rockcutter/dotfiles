setup:
ifeq ($(OS), Windows_NT)
	Copy-Item -Path nvim -Destination $${HOME}/AppData/Local/nvim -Recurse -Force
else
	cp -r nvim $${HOME}/.config/nvim
endif

