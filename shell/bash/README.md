use default.bashrc on remote server 

```sh
# ~/.ssh/config
HOST host_name
    Hostname host.example.com
    User user
    Port 22
    ServerAliveInterval 60
    ServerAliveCountMax 60
    RequestTTY yes
    RemoteCommand mkdir -p /tmp/rockcutter/dotfiles; curl -o /tmp/rockcutter/dotfiles/default.bashrc https://raw.githubusercontent.com/rockcutter/dotfiles/refs/heads/main/shell/bash/default.bashrc; bash --rcfile /tmp/rockcutter/dotfiles/default.bashrc
```
