# dotcompany-template

Claude Code で 6部署の仮想カンパニーを運営するプラグイン **+ Anthropic公式 financial-services エージェント丸ごとバンドル** です。

**[ドキュメント](https://github.com/sammyTI/dotcompany-template)**

`/company` を実行すると、秘書があなた専用の窓口になります。3問のヒアリングで即運用開始。
6部署（秘書 / CEO / マーケ / 開発 / 経理 / 営業）が最初から揃います。

加えて、Anthropic公式の **Pitch Agent / Market Researcher / Meeting Prep Agent / Month-End Closer** など 17個のエージェント・スキルプラグインを同梱しています（Apache 2.0、帰属表記済み）。ピッチデック、競合調査、決算レビュー、月次決算などをそのまま使えます。

## インストール

Claude Code 内で、以下を順に実行してください。

```
/plugin marketplace add sammyTI/dotcompany-template
/plugin install company@dotcompany-template
```

追加でAnthropicの財務系エージェントを使いたい場合（任意）:

```
/plugin install pitch-agent@dotcompany-template
/plugin install market-researcher@dotcompany-template
/plugin install meeting-prep-agent@dotcompany-template
/plugin install month-end-closer@dotcompany-template
```

その後、自分のプロジェクトで:

```
/company
```

これだけで、3問のヒアリングのあと `.company/` が自動生成されます。

## コンセプト

```
あなた → 秘書（窓口） → CEO（振り分け） → 各部署
```

- **秘書**: 常に窓口。TODO管理、壁打ち、メモ、何でも相談OK
- **CEO**: 裏で部署振り分け。意思決定をログに残す
- **6部署**: 秘書 / CEO / マーケ / 開発 / 経理 / 営業 が最初から揃う

ユーザーは部署を意識しなくていい。秘書が判断して振り分けてくれます。

## 使い方

### 初回セットアップ（3問だけ）

```
> /company

秘書: はじめまして！あなたの秘書になります。
      お名前を教えてください。
あなた: 岡村さみー

秘書: 事業や活動を教えてください。
あなた: フリーランスのWeb開発やってます

秘書: 今の目標や困りごとは？
あなた: SaaSを作って月10万目指してる。タスクが散らかるのが悩み

→ .company/ が自動生成される（完了！）
```

### 日常の運営

```
> /company
秘書: おはようございます！何かありますか？

> 今日やること教えて
秘書: 今日のTODOです:
  - [ ] クライアントAへ見積もり送付
  - [ ] LP設計書のレビュー

> 競合サービスについて調べて
秘書: 承知しました。調べますね。
  → marketing/content-plan/ に保存

> 商談の提案書作って
秘書: 営業に振りますね → sales/proposals/ にドラフトを作ります
```

## 6部署の役割

| 部署 | フォルダ | 担当領域 |
|------|---------|---------|
| 秘書室 | `secretary/` | 窓口・TODO管理・壁打ち・メモ |
| CEO | `ceo/` | 意思決定・部署振り分け（裏方） |
| マーケティング | `marketing/` | コンテンツ企画・SNS・キャンペーン |
| 開発 | `engineering/` | 技術ドキュメント・設計・デバッグ |
| 経理 | `finance/` | 請求書・経費・売上 |
| 営業 | `sales/` | クライアント・提案書・案件管理 |

## 生成されるファイル構成

`/company` を初回実行すると、以下が自動で作られます。

```
.company/
├── CLAUDE.md              ← 組織全体のルール（プロフィール反映済み）
├── secretary/
│   ├── CLAUDE.md
│   ├── inbox/             ← クイックキャプチャ
│   ├── todos/             ← 日次TODO（YYYY-MM-DD.md）
│   └── notes/             ← 壁打ち・相談メモ
├── ceo/
│   ├── CLAUDE.md
│   └── decisions/         ← 意思決定ログ
├── marketing/
│   ├── CLAUDE.md
│   ├── content-plan/
│   └── campaigns/
├── engineering/
│   ├── CLAUDE.md
│   ├── docs/
│   └── debug-log/
├── finance/
│   ├── CLAUDE.md
│   ├── invoices/
│   ├── expenses/
│   └── receipts/
└── sales/
    ├── CLAUDE.md
    ├── clients/
    └── proposals/
```

## ブラウザで可視化（任意）

組織状況をブラウザで確認したい場合:

```bash
npx cc-company-dashboard
```

機能: TODO数・部署アクティビティ・ファイル階層ツリー・Obsidian風グラフビュー・全文検索・リアルタイム更新

このリポジトリ内の `packages/dashboard/` は、上記をforkしたdotcompany用リブランド版（ダークモード既定）です。

## アンインストール

```
/plugin uninstall company@dotcompany-template
/plugin marketplace remove sammyTI/dotcompany-template
```

`.company/` フォルダは残ります（手動で削除してください）。

## バンドルされている Anthropic 公式エージェント

`plugins/agent-plugins/` `plugins/vertical-plugins/` `managed-agent-cookbooks/` は [anthropics/financial-services](https://github.com/anthropics/financial-services) からの vendored コピー（Apache 2.0）です。

### Agent plugins（10個）

| Plugin | 用途 |
|---|---|
| `pitch-agent` | comps・precedents・LBO → ブランド付きピッチデック |
| `market-researcher` | セクター/テーマ → 業界概観・競合・peer comps |
| `meeting-prep-agent` | クライアント面談前のブリーフィングパック |
| `earnings-reviewer` | 決算コール+filing → モデル更新 → ノート |
| `model-builder` | DCF/LBO/3-statement/comps を Excel上で構築 |
| `gl-reconciler` | GL差異検出・根本原因追跡 |
| `month-end-closer` | 月次決算・accruals・variance commentary |
| `valuation-reviewer` | GPパッケージ → バリュエーション → LP reporting |
| `statement-auditor` | LP statement の事前監査 |
| `kyc-screener` | オンボーディング書類解析・ルール評価 |

### Vertical plugins（7個・スキル単体配布）

`financial-analysis` / `investment-banking` / `equity-research` / `private-equity` / `wealth-management` / `fund-admin` / `operations`

スキル単体（`/dcf` `/comps` `/earnings` 等）だけ欲しい場合は vertical のほうを入れる。

⚠️ Anthropic原文の免責事項: これらは投資・法律・税務・会計のアドバイスではありません。アナリスト作業のドラフト生成用で、最終的な判断は資格を持つ専門家のレビューが必要です。詳細は `NOTICE` ファイル参照。

## ライセンス

- 自作部分（`plugins/company/` ほか）: **MIT**
- バンドル部分（`plugins/agent-plugins/`、`plugins/vertical-plugins/`、`managed-agent-cookbooks/`）: **Apache 2.0**（`plugins/LICENSE-APACHE` 参照）

## 元ネタ

- 6部署仮想カンパニーのコンセプト: [Shin-sibainu/cc-company](https://github.com/Shin-sibainu)
- ダッシュボード: 同氏の cc-company-dashboard を fork
- Agent / Vertical plugins: [anthropics/financial-services](https://github.com/anthropics/financial-services)
