BINARY_PATH := /usr/local/bin
TEMP_FILE := "_make_install_temp_file"
TEMP_DIR := "_make_install_temp_dir"

.PHONY: all
all: zellij ghq 

.PHONY: zellij
zellij:
	curl -L -o - https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar zxvf - -C $(BINARY_PATH)

.PHONY: ghq
ghq:
	curl -o $(TEMP_FILE) https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_amd64.zip -L 
	unzip $(TEMP_FILE) -d $(TEMP_DIR)
	mv $(TEMP_DIR)/ghq_linux_amd64/ghq $(BINARY_PATH)
	-@rm $(TEMP_FILE)
	-@rm -rf $(TEMP_DIR)
	
.PHONY: clean
clean: 
	-@rm $(TEMP_FILE)
	-@rm -rf $(TEMP_DIR)


