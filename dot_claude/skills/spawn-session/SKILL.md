---
name: spawn-session
description: 指定したリポジトリ（ディレクトリ）で worker セッションを `claude --bg` で起動し、親セッションから SendMessage で連絡できる状態にする。「<repo> にセッション立てて」「別セッション召喚して」「worker 立てて」「このタスクを別リポで走らせて」のような依頼で使う。
allowed-tools:
  - Bash(claude:*)
  - ListAgents
  - SendMessage
---

# spawn-session

`<dir>` は worker を動かすディレクトリの絶対パス、`<指示>` は worker に最初に渡す文。どちらも会話から決める。指示が無ければ worker を待機状態で起動する。

## 手順

1. 起動する。指示が無ければ末尾の引数を外す

   ```sh
   cd <dir> && claude --bg -n "<一言の名前>" --model opus --effort medium "<指示>"
   ```

   出力 `backgrounded · <id> · <name>` の `<id>` を控える。

2. ListAgents を呼び、起動した worker の `[ref]` を控える。起動直後は載らないことがあるので、無ければ数秒おいて再度呼ぶ。表示名は hook 等で後から変わるので、追跡は ref で行う。

3. id と ref をユーザーに伝える。後でこの会話から worker を探す手がかりになる。

## 連絡

- worker へ: ListAgents で ref を含む行を探し、その行の `name [ref]` をそのまま SendMessage の宛先にする
- worker から親へ返事が欲しいときは、指示に「親は ListAgents で `[<親 ref>]` を含む行。完了したら SendMessage で報告」と添える。親の ref は ListAgents の先頭行 `This session is <name> [<ref>]` にある

## 片付け

- `claude rm <id>`。会話ログは残り、`claude --resume <uuid>` で再開できる（uuid は `claude agents --json` の `sessionId`）
- `claude attach <id>` で人が端末から引き継げる

## 注意

- `--bg` と `-p` は併用できない
- settings.json の `worktree.bgIsolation` が `none` でないと、`--bg` が自前の worktree を切って `<dir>` から外れる
- worker は settings.json の permission 設定を継承する
