# dotcompany-dashboard

[dotcompany-template](https://github.com/sammyTI/dotcompany-template) の組織状況をブラウザで確認できるダッシュボード。
ダークモード既定。`.company/` フォルダがあるディレクトリで動作します。

## 使い方

`.company/` があるプロジェクトで実行:

```bash
npx dotcompany-dashboard
```

ブラウザが自動で開きます（http://localhost:3939）。

## オプション

```bash
npx dotcompany-dashboard --port 4000    # ポート変更
npx dotcompany-dashboard --no-open      # ブラウザ自動起動を無効化
npx dotcompany-dashboard --dir /path    # .company/ を探すディレクトリを指定
```

## 機能

- **Dashboard** — TODO数、Inbox件数、部署数、アクティビティをひと目で確認
- **Explorer** — ファイル階層をツリー表示
- **Graph** — Obsidian風ネットワーク可視化
- **Search** — 全ファイル全文検索
- **部署詳細** — Markdownプレビュー / 生テキスト切替
- **ライト / ダークモード** — ワンクリック切替
- **リアルタイム更新** — ファイル変更を自動検出

## 前提条件

- Node.js 18+
- `.company/` フォルダ

## ライセンス

MIT
