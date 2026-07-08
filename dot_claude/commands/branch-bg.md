---
description: 現在のセッションを分岐(fork)し、バックグラウンドセッションとして再開する
argument-hint: <分岐先セッションにやらせる指示>
allowed-tools: Bash(claude:*)
disable-model-invocation: true
---

現在のセッションを --fork-session で複製し、バックグラウンドセッションとして起動した。
実行結果:

```!
claude --resume "${CLAUDE_SESSION_ID}" --fork-session --bg "$ARGUMENTS"
```

- 出力に表示された短縮IDが分岐後のバックグラウンドセッション
- 元のセッション(このセッション)は新しいIDに分岐して起動されるため影響を受けない
- 接続: `claude attach <id>` / ログ確認: `claude logs <id>` / 停止: `claude stop <id>`

ユーザーには分岐後のセッションIDと上記の操作方法を簡潔に伝えること。
prompt required エラーが出ている場合は、`/branch-bg <指示>` のように
バックグラウンドセッションへの指示を引数で渡す必要があることを伝えること。
