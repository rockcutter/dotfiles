# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

chezmoiを使用したdotfiles管理リポジトリ。macOS/Linuxの設定ファイルを管理。

## Commands

```bash
# dotfilesの適用
chezmoi apply

# 変更のプレビュー（dry-run）
chezmoi diff

# ソースディレクトリの編集後に適用
chezmoi apply --verbose

# 実際のファイルとソースの差分確認
chezmoi diff

# 新しいdotfileを管理対象に追加
chezmoi add ~/.some_config
```

## Architecture

### chezmoi Naming Conventions

- `dot_` prefix → `.` に変換（例: `dot_zshrc` → `.zshrc`）
- `private_` prefix → パーミッション600で作成
- `.tmpl` suffix → Go templateとして処理（例: `dot_gitconfig.tmpl`）
- ディレクトリも同様（例: `dot_config/` → `.config/`）

### Directory Structure

```
dot_claude/          → ~/.claude/ (Claude Code設定)
dot_config/          → ~/.config/
  nvim/              → Neovim設定
  espanso/           → テキスト展開ツール
  i3status/          → i3status設定
  sway/              → Swayウィンドウマネージャ
private_dot_ssh/     → ~/.ssh/ (パーミッション制限付き)
```

### Template Variables

`dot_gitconfig.tmpl` などで使用するテンプレート変数は `~/.config/chezmoi/chezmoi.toml` で定義:

```toml
[data]
    email = "your-email@example.com"
```

### .chezmoiignore

chezmoi適用時に無視されるファイル: `v2/**`, `README.md`, `default.bashrc`
