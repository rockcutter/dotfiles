

install chezmoi 
https://www.chezmoi.io/install/

```sh
chezmoi init --apply --verbose git@github.com:rockcutter/dotfiles.git
```

```sh
cat > ~/.config/chezmoi/chezmoi.toml << 'EOF'
[data]
    email = ""
EOF
```

