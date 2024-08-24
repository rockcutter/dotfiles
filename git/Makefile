
sync:
ifeq ($(OS), Windows_NT)
	Copy-Item -Path .gitconfig -Destination $${HOME}/.gitconfig -Force
else
	cp .gitconfig $${HOME}/.gitconfig
endif
