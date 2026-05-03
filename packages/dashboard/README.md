# dotcompany-dashboard

[dotcompany-template](https://github.com/sammyTI/dotcompany-template) の組織状況をブラウザで確認できるダッシュボード。

[cc-company-dashboard](https://github.com/Shin-sibainu/cc-company) からのフォーク。任意の `.company/` フォルダで動作する（cc-companyとも互換）。

## 使い方

`.company/` があるプロジェクトで実行：

```bash
# このパッケージをローカルでビルド
cd packages/dashboard
npm install
npm run build

# 起動
node bin/cli.js
```

または、自分のプロジェクトのルートから（`.company/` を自動検出）:

```bash
node /path/to/dotcompany-template/packages/dashboard/bin/cli.js
```

ブラウザが自動で開きます（http://localhost:3939）。

## オプション

```bash
node bin/cli.js --port 4000    # ポート変更
node bin/cli.js --no-open      # ブラウザ自動起動を無効化
node bin/cli.js --dir /path    # .company/ を探すディレクトリを指定
```

## 機能

- **Dashboard** — TODO数、Inbox件数、部署数、アクティビティをひと目で確認
- **Explorer** — ファイル階層をツリー表示
- **Graph** — Obsidian風ネットワーク可視化
- **Search** — 全ファイル全文検索
- **部署詳細** — Markdownプレビュー / 生テキスト切替
- **ライト / ダークモード** — ワンクリック切替
- **リアルタイム更新** — ファイル変更を自動検出

## カスタマイズ・リバート

CSS は `src/App.css` と `src/index.css`、コンポーネントは `src/components/` にある。
リブランド・リデザインしたい場合はそこを編集して `npm run build` でリビルド。

**baseline（フォーク直後の状態）に戻したいとき:**

```bash
# baseline コミットを探す
git log --oneline packages/dashboard | grep baseline

# packages/dashboard だけ baseline に戻す
git checkout <baseline-sha> -- packages/dashboard
```

または特定ファイルだけ:

```bash
git checkout <baseline-sha> -- packages/dashboard/src/App.css
```

## 前提条件

- Node.js 18+
- `.company/` フォルダ（dotcompany-template または cc-company で生成）

## ライセンス

MIT（cc-company-dashboard と同じ）
