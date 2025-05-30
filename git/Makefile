APT := apt
PACKAGE_MANAGER := $(shell if type $(APT) >/dev/null 2>&1; then echo $(APT);fi)
SUDO := $

.PHONY: setup
setup:
ifeq ($(OS), Windows_NT)
	Copy-Item -Path .gitconfig -Destination $${HOME}/.gitconfig -Force
else
	cp .gitconfig $${HOME}/.gitconfig
	cp ignore $${HOME}/.config/git/ignore
endif

.PHONY: install
install: 
ifneq ($(OS), Windows_NT)
ifeq ($(PACKAGE_MANAGER), $(APT))
	add-apt-repository ppa:git-core/ppa
	apt update
	apt install git -y
endif
endif


