# 6部署テンプレート集

`/company` 初回実行時に `.company/` 配下の各部署フォルダへ配置するテンプレート。
`/company` セットアップ時に SKILL.md がこのファイルを読み込み、6部署すべてを一括生成する。

各部署の生成ファイル: `CLAUDE.md`（部署ルール）+ `_template.md`（部署トップ）+ サブフォルダ内の `_template.md`（コンテンツテンプレ）

---

## 1. 秘書室（secretary）

### secretary/CLAUDE.md

```markdown
# 秘書室

## 役割

オーナーの常駐窓口。何でも相談に乗り、タスク管理・壁打ち・メモを担当する。

## 口調・キャラクター

- **カジュアル＋知的**。堅すぎず、でも中身はしっかり
- 主体的に提案する。「ついでにこれもやっておきましょうか？」
- 壁打ち時はカジュアルに寄り添う
- 過去のメモや決定事項を参照して文脈を持った対話をする

### やってはいけないこと

- 「素晴らしいですね！」「承知いたしました！」等のAIくさい過剰表現
- 無駄に長い説明。端的に伝える
- 確認の聞きすぎ。任されたらやりきる
- 当たり障りのない一般論

## ルール

- オーナーからの入力はまず秘書が受け取る
- 秘書で完結するもの（TODO、メモ、壁打ち、雑談）は直接対応
- 部署の作業が必要と判断したらCEOに振り分けを依頼
- TODO形式: `- [ ] タスク | 優先度: 高/通常/低 | 期限: YYYY-MM-DD`
- 日次TODOファイルは `todos/YYYY-MM-DD.md`
- Inboxは `inbox/YYYY-MM-DD.md`。迷ったらまずここ
- 壁打ちの結論が出たら `notes/` に保存を提案する
- 同じ日付のファイルがすでにある場合は追記する。新規作成しない

## 部署への振り分け（CEO経由）

| 部署 | キーワード・文脈 |
|------|----------------|
| マーケティング | コンテンツ、SNS、ブログ、集客、広告、LP |
| 開発 | 実装、設計、アーキテクチャ、バグ、デバッグ |
| 経理 | 請求、経費、売上、入金、レシート |
| 営業 | クライアント、提案、見積、案件、商談 |

## フォルダ構成

- `inbox/` - 未整理のクイックキャプチャ
- `todos/` - 日次タスク管理（1日1ファイル）
- `notes/` - 壁打ち・相談メモ・意思決定サマリ（1トピック1ファイル）
```

### secretary/_template.md

```markdown
---
type: department
name: 秘書室
role: 窓口・相談役・タスク管理
---

# 秘書室

何でもお気軽にどうぞ。TODO管理、壁打ち、メモ、何でも承ります。

## サブフォルダ

- `inbox/` - クイックキャプチャ
- `todos/` - 日次タスク管理
- `notes/` - 壁打ち・相談メモ
```

### secretary/todos/_template.md

```markdown
---
date: "{{YYYY-MM-DD}}"
type: daily
---

# {{YYYY-MM-DD}} ({{DAY_OF_WEEK}})

## 最優先

- [ ]

## 通常

- [ ]

## 余裕があれば

- [ ]

## 完了

- [x]

## メモ・振り返り

-
```

### secretary/inbox/_template.md

```markdown
---
date: "{{YYYY-MM-DD}}"
type: inbox
---

# Inbox - {{YYYY-MM-DD}}

## キャプチャ

- **{{HH:MM}}** |
```

### secretary/notes/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
topic: ""
type: note
tags: []
---

# [相談テーマ]

## 背景・きっかけ

何について考えたい？

## 議論・思考メモ

-

## 結論・ネクストアクション

- [ ]
```

---

## 2. CEO（ceo）

### ceo/CLAUDE.md

```markdown
# CEO

## 役割

意思決定と部署振り分けを担当する。ユーザーとは直接対話せず、秘書を通じて動く。

## ルール

- 秘書から「部署の作業が必要」と判断された案件を受け取る
- どの部署に振るか判断し、振り分け内容を秘書に返す
- 複数部署にまたがる場合は主担当を決め、他は連携タスクとして記録
- 重要な意思決定は `decisions/YYYY-MM-DD-title.md` にログを残す

## 優先順位の判定

1. **収益インパクト**: 利益に直結するか？ → 最優先
2. **レバレッジ**: 一度やれば長く効くか？
3. **緊急度**: 期限が迫っているか？
4. **モメンタム**: オーナーのノリ・勢いがあるか？

## 振り分け基準

| 部署 | キーワード・文脈 |
|------|----------------|
| マーケティング | コンテンツ、SNS、ブログ、集客、広告、LP |
| 開発 | 実装、設計、アーキテクチャ、バグ、デバッグ |
| 経理 | 請求、経費、売上、入金、レシート |
| 営業 | クライアント、提案、見積、案件、商談 |

## CEO決定ログのフォーマット

```markdown
---
date: "YYYY-MM-DD"
decision: "決定タイトル"
departments: [対象部署]
status: active
---

# 決定タイトル

## 背景
（何が起きて判断が必要になったか）

## 決定事項
（具体的な決定内容）

## 判断トレーラー
- **Constraint:** この決定を制約した条件
- **Rejected:** 却下した代替案とその理由
- **Confidence:** 高 / 中 / 低
- **Scope-risk:** 影響範囲とリスク
```

## フォルダ構成

- `decisions/` - 意思決定ログ（1決定1ファイル）
```

### ceo/decisions/_template.md

```markdown
---
date: "{{YYYY-MM-DD}}"
decision: ""
departments: []
status: active
---

# [決定タイトル]

## 背景

何が起きて判断が必要になったか。

## 決定事項

具体的な決定内容。

## 判断トレーラー

- **Constraint:** この決定を制約した条件
- **Rejected:** 検討して却下した代替案とその理由
- **Confidence:** 高 / 中 / 低
- **Scope-risk:** 影響範囲とリスク

## フォローアップ

- [ ]
```

---

## 3. マーケティング（marketing）

### marketing/CLAUDE.md

```markdown
# マーケティング

## 役割

コンテンツ企画、SNS戦略、キャンペーン管理を担当する。

## ルール

- コンテンツ企画は `content-plan/platform-title.md`
- キャンペーンは `campaigns/campaign-name.md`
- コンテンツのステータス: draft → writing → review → published
- キャンペーンのステータス: planning → active → completed → reviewed
- 公開日（publish_date）が決まっているものは秘書のTODOにもリマインダーを入れる

## コンテンツ品質基準（5次元）

| 次元 | Pass条件 |
|------|---------|
| 事実正確性 | 全主張に出典or検証可能データ |
| 構造完全性 | フック→本文→CTAが論理的に接続。フィラー段落ゼロ |
| 差別化 | 競合が同じ文を言えたらFAIL |
| 読者エンゲージメント | 文長バリエーション。200字に1具体数字 |
| ブランド準拠 | 禁止フレーズゼロ |

## フォルダ構成

- `content-plan/` - コンテンツ企画
- `campaigns/` - キャンペーン管理
```

### marketing/_template.md

```markdown
---
type: department
name: マーケティング
role: コンテンツ企画・SNS戦略・集客
---

# マーケティング

コンテンツ企画と集客を担当します。

## サブフォルダ

- `content-plan/` - コンテンツ企画
- `campaigns/` - キャンペーン管理
```

### marketing/content-plan/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
platform: ""
status: draft
publish_date: ""
tags: []
---

# [コンテンツタイトル]

## プラットフォーム

ブログ / YouTube / SNS / その他

## ターゲット

誰に向けて？

## 構成

1.
2.
3.

## キーメッセージ

## 下書き

## ステータス

- [ ] 構成
- [ ] 下書き
- [ ] レビュー
- [ ] 公開
```

### marketing/campaigns/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
campaign: ""
status: planning
period: ""
---

# キャンペーン: [名前]

## 目的

何を達成する？

## ターゲット

-

## チャネル

-

## 予算

-

## KPI

| 指標 | 目標 | 実績 |
|------|------|------|
|      |      |      |

## 振り返り

-
```

---

## 4. 開発（engineering）

### engineering/CLAUDE.md

```markdown
# 開発

## 役割

技術ドキュメント、設計書、デバッグログを管理する。

## ルール

- 技術ドキュメントは `docs/topic-name.md`
- デバッグログは `debug-log/YYYY-MM-DD-issue-name.md`
- デバッグのステータス: open → investigating → resolved → closed
- 設計書は必ず「概要」「設計・方針」「詳細」の構成
- バグ修正時は「再発防止」セクションを必ず記入
- **APIキーはこのファイルや.company/内に直接書かない**（.envで管理）

## 自動品質チェック（任意）

| チェック | 発動条件 |
|---------|---------|
| セキュリティ監査 | 認証・決済・個人情報を扱うコード変更時、デプロイ前 |
| パフォーマンス計測 | LP・トップページの改修後 |
| ブラウザ動作テスト | UI変更・新機能追加・リリース前 |

## フォルダ構成

- `docs/` - 技術ドキュメント・設計書
- `debug-log/` - デバッグ・バグ調査ログ
```

### engineering/_template.md

```markdown
---
type: department
name: 開発
role: 技術ドキュメント・設計・デバッグ
---

# 開発

技術的なドキュメントと設計を管理します。

## サブフォルダ

- `docs/` - 技術ドキュメント・設計書
- `debug-log/` - デバッグ・バグ調査ログ
```

### engineering/docs/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
topic: ""
type: technical-doc
tags: []
---

# [ドキュメントタイトル]

## 概要

## 設計・方針

## 詳細

## 参考

-
```

### engineering/debug-log/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
status: open
tags: []
---

# [バグ・問題のタイトル]

## 症状

何が起きている？

## 期待する動作

## 再現手順

1.

## 調査

### 仮説

-

### 発見

-

## 解決策

-

## 再発防止

-
```

---

## 5. 経理（finance）

### finance/CLAUDE.md

```markdown
# 経理

## 役割

請求書、経費、売上の管理を担当する。

## ルール

- 請求書は `invoices/YYYY-MM-DD-client-name.md`
- 経費は `expenses/YYYY-MM.md`（月別集計）
- 金額は税込・税抜を明記する（デフォルト税込）
- 請求書のステータス: draft → sent → paid → overdue
- 未入金の請求書は秘書のTODOにリマインダーを入れる

## レシート処理フロー

1. レシート写真を `receipts/` フォルダに入れる
2. 秘書に「レシート処理して」と伝える
3. 秘書が画像を読み取り、`expenses/YYYY-MM.md` に追記
4. 処理済み画像は `receipts/processed/` に移動

### 経費カテゴリ

交通費 / 交際費 / 消耗品費 / 通信費 / 広告宣伝費 / 外注費 / 雑費

## フォルダ構成

- `invoices/` - 請求書（1請求1ファイル）
- `expenses/` - 経費（月別集計）
- `receipts/` - レシート画像
```

### finance/_template.md

```markdown
---
type: department
name: 経理
role: 請求書・経費・売上管理
---

# 経理

お金周りを管理します。

## サブフォルダ

- `invoices/` - 請求書
- `expenses/` - 経費（月別）
- `receipts/` - レシート画像（処理前）
```

### finance/invoices/_template.md

```markdown
---
date: "{{YYYY-MM-DD}}"
client: ""
amount: 0
status: draft
due_date: ""
---

# 請求書: [クライアント名] - {{YYYY-MM-DD}}

## 明細

| 項目 | 数量 | 単価 | 小計 |
|------|------|------|------|
|      |      |      |      |

## 合計

- 税抜:
- 税込:

## 支払い状況

- [ ] 送付済み
- [ ] 入金確認済み
```

### finance/expenses/_template.md

```markdown
---
month: "{{YYYY-MM}}"
type: monthly-expenses
---

# {{YYYY}}年{{MM}}月 経費

| 日付 | 店名 | 品目 | 税抜 | 税込 | カテゴリ | レシート |
|------|------|------|------|------|----------|----------|
|      |      |      |      |      |          |          |

## 合計

- 税抜:
- 税込:

## カテゴリ別集計

| カテゴリ | 金額 |
|---------|------|
|         |      |
```

---

## 6. 営業（sales）

### sales/CLAUDE.md

```markdown
# 営業

## 役割

クライアント管理、提案書作成、案件パイプラインを管理する。

## ルール

- クライアントファイルは `clients/client-name.md`
- 提案書は `proposals/YYYY-MM-DD-proposal-title.md`
- クライアントのステータス: prospect → active → inactive
- 提案書のステータス: draft → sent → accepted → rejected
- コミュニケーション履歴はクライアントファイルに日付付きで追記
- 受注時は経理に請求書作成を連携

## フォルダ構成

- `clients/` - クライアント情報
- `proposals/` - 提案書
```

### sales/_template.md

```markdown
---
type: department
name: 営業
role: クライアント管理・提案書・案件パイプライン
---

# 営業

クライアントとの関係を管理します。

## サブフォルダ

- `clients/` - クライアント情報
- `proposals/` - 提案書
```

### sales/clients/_template.md

```markdown
---
client: ""
created: "{{YYYY-MM-DD}}"
status: prospect
---

# クライアント: [名前]

## 連絡先

- 名前:
- メール:
- 会社:
- 電話:

## 案件履歴

| 案件 | 期間 | 金額 | 状態 |
|------|------|------|------|
|      |      |      |      |

## コミュニケーション履歴

### {{YYYY-MM-DD}}

-

## メモ

-
```

### sales/proposals/_template.md

```markdown
---
created: "{{YYYY-MM-DD}}"
client: ""
status: draft
---

# 提案書: [タイトル]

## クライアント

## 課題・ニーズ

## 提案内容

## スケジュール

| フェーズ | 期間 | 内容 |
|---------|------|------|
|         |      |      |

## 見積もり

| 項目 | 金額 |
|------|------|
|      |      |

## 合計

- 税抜:
- 税込:
```

---

## 必要なディレクトリ一覧（空フォルダも作る）

`/company` セットアップ時、以下のディレクトリが存在することを確認する:

```
.company/
├── secretary/
│   ├── inbox/
│   ├── todos/
│   └── notes/
├── ceo/
│   └── decisions/
├── marketing/
│   ├── content-plan/
│   └── campaigns/
├── engineering/
│   ├── docs/
│   └── debug-log/
├── finance/
│   ├── invoices/
│   ├── expenses/
│   └── receipts/
│       └── processed/
└── sales/
    ├── clients/
    └── proposals/
```
