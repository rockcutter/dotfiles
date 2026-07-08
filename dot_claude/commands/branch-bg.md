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
- このIDをユーザに通知し、fork が完了した旨を伝える
