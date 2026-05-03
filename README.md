# Claude Codeを会社化する仕組み

Claude Codeに、フォルダ一個、放り込むだけ。
中には、6部署のAIチームが入っています。

**秘書 / CEO / マーケ / 開発 / 経理 / 営業**

あなたが話すのは、秘書ひとり。
指示が雑でも、6部署が勝手に補正してくれます。

---

## 1分でセットアップ（コピペ1行）

自分のプロジェクトのフォルダに移動した状態で、下のコマンドを **コピー → ペースト → Enter** を押すだけです。

### Mac / Linux

「ターミナル」アプリ（macOS標準）または「iTerm」などで:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/sammyTI/dotcompany-template/main/install.sh)
```

### Windows

「PowerShell」または「Windows Terminal」で:

```powershell
irm https://raw.githubusercontent.com/sammyTI/dotcompany-template/main/install.ps1 | iex
```

> 💡 Windows 10 (1803以降) または Windows 11 をお使いください。古いWindowsの場合は WSL（Windows Subsystem for Linux）で Mac/Linux の手順を使ってください。

---

これだけで、

1. `.company/` フォルダ（6部署のAIチーム）がプロジェクトに置かれます
2. `/company` スラッシュコマンドがこのプロジェクトで使えるようになります
3. 次にやるべきこと（プロフィール編集など）が画面に出ます

> 💡 「自分のプロジェクト」がまだない方は、空のフォルダを作ってから実行してください。
>
> - Mac/Linux: `mkdir my-company && cd my-company`
> - Windows: `mkdir my-company; cd my-company`

---

## これは何ですか？

Claude Codeで「自分専用の仮想カンパニー」を運営するためのテンプレートです。
`.company/` ディレクトリを自分のプロジェクトに置くだけで、Claude Codeが**6部署のAIチーム**として振る舞ってくれるようになります。

- **秘書**が常駐窓口になります。TODO管理、メモ、壁打ち、何でも受け付けてくれます
- **CEO**が裏で部署振り分けを担当します。意思決定をログに残してくれます
- **マーケ・開発・経理・営業**が必要に応じて動いてくれます
- 日々のメモ・決定・タスクは全て `.company/` 内のmdファイルに自動で蓄積されます
- 1ヶ月後・1年後も、過去の判断と背景を秘書が思い出してくれます

---

## 他のセットアップ方法

ワンライナーが使えない・別の方法が好みの方向け。

### 方法B. Claude Codeのプラグインとして導入

すべてのプロジェクトで `/company` を使いたい方はこちら。

Claude Code 内で、以下を順に実行してください。

```
/plugin marketplace add sammyTI/dotcompany-template
/plugin install company@dotcompany-template
```

その後、`.company/` フォルダを自分のプロジェクトに配置します。

```bash
git clone https://github.com/sammyTI/dotcompany-template.git /tmp/dot
cp -r /tmp/dot/.company /path/to/your/project/
```

プロジェクトで `/company` を実行すると、秘書モードが起動します。

### 方法C. 完全手動（プラグインなし）

```bash
git clone https://github.com/sammyTI/dotcompany-template.git /tmp/dot
cp -r /tmp/dot/.company /path/to/your/project/
```

Claude Code起動後に、こう伝えてください。

```
.company/CLAUDE.md を読んで、秘書として動いてください
```

毎回手動で伝えるのが手間な場合は、方法Aか方法Bをおすすめします。

---

## 共通: プロフィールを書きましょう

どの方法でも、最後に `.company/CLAUDE.md` の **オーナープロフィール** セクションを自分の情報に書き換えます。

- 名前・役職
- 事業・活動
- ミッション（短くてOKです）
- 言語

これで秘書が「あなた専用」になります。

---

## ブラウザで可視化（任意）

組織の状況をブラウザで一覧したい場合は、ダッシュボードを使えます。

```bash
# .company/ があるプロジェクトのフォルダで実行
npx cc-company-dashboard
```

機能:

- TODO数・Inbox件数・部署アクティビティのカード
- ファイル階層ツリー
- Obsidian風グラフビュー
- 全文検索
- リアルタイム更新

> このリポジトリ内の `packages/dashboard/` は、上記を fork して dotcompany 用にリブランドしたものです。`cd packages/dashboard && npm install && npm run build && node bin/cli.js` で起動できます（デフォルトはダークモードです）。

---

## 日常の使い方

### TODO管理

```
> 今日のTODO見せて
秘書: 今日のTODOです:
  - [ ] クライアントAへ見積もり送付
  - [ ] LP設計書のレビュー

> 明日までに資料作る、追加しておいて
秘書: 追加しました。優先度は通常でいいですか？
```

### 壁打ち・相談

```
> 新しいSaaSのアイデアあるんだけど壁打ちしたい
秘書: いいですね。どんなアイデアですか？
... (対話で深掘り)
秘書: 結論まとまりましたね。secretary/notes/ に保存しておきます。
```

### 部署の自動振り分け

```
> 今月の経費まとめて
秘書: 経理に振りますね → finance/expenses/ に集計します

> 商談の提案書作って
秘書: 営業に振りますね → sales/proposals/ にドラフトを作ります

> あの件、どう判断したっけ？
秘書: ceo/decisions/ を見てきます → 該当する決定ログを見つけました
```

ユーザーは部署を意識する必要はありません。秘書が判断して振り分けてくれます。

---

## 部署の役割

| 部署 | フォルダ | 担当領域 |
|------|---------|---------|
| 秘書室 | `secretary/` | 窓口・TODO管理・壁打ち・メモ |
| CEO | `ceo/` | 意思決定・部署振り分け（裏方） |
| マーケティング | `marketing/` | コンテンツ企画・SNS・キャンペーン |
| 開発 | `engineering/` | 技術ドキュメント・設計・デバッグ |
| 経理 | `finance/` | 請求書・経費・売上 |
| 営業 | `sales/` | クライアント・提案書・案件管理 |

各部署フォルダの `CLAUDE.md` に、その部署のルール・振る舞いが書かれています。
カスタマイズしたい場合はそこを編集してください。

---

## ファイル構成

```
dotcompany-template/
├── README.md
├── LICENSE
├── install.sh                         ← ワンライナー導入用（Mac/Linux）
├── install.ps1                        ← ワンライナー導入用（Windows PowerShell）
├── .claude-plugin/
│   └── marketplace.json               ← プラグイン配布マニフェスト
├── plugins/
│   └── company/
│       ├── .claude-plugin/plugin.json
│       └── skills/company/SKILL.md    ← /company の振る舞い定義
├── packages/
│   └── dashboard/                     ← ブラウザ用ダッシュボード（fork版）
└── .company/                          ← ★ ドロップイン本体（プロジェクトに配置）
    ├── CLAUDE.md                      ← 組織全体のルール（最初にここを読みます）
    ├── secretary/
    │   ├── CLAUDE.md                  ← 秘書の振る舞い
    │   ├── inbox/                     ← クイックメモ
    │   ├── todos/                     ← 日次TODO（YYYY-MM-DD.md）
    │   └── notes/                     ← 壁打ち・相談ログ
    ├── ceo/
    │   ├── CLAUDE.md                  ← 振り分けロジック
    │   └── decisions/                 ← 意思決定ログ
    ├── marketing/
    │   ├── CLAUDE.md
    │   ├── content-plan/              ← 記事・投稿の企画
    │   └── campaigns/                 ← キャンペーン管理
    ├── engineering/
    │   ├── CLAUDE.md
    │   ├── docs/                      ← 技術ドキュメント
    │   └── debug-log/                 ← バグ調査ログ
    ├── finance/
    │   ├── CLAUDE.md
    │   ├── invoices/                  ← 請求書
    │   ├── expenses/                  ← 経費
    │   └── receipts/                  ← レシート画像（処理前）
    └── sales/
        ├── CLAUDE.md
        ├── clients/                   ← クライアント情報
        └── proposals/                 ← 提案書
```

各サブフォルダには `_template.md` が入っています。新規作成時はこれをコピーして使ってください。

---

## カスタマイズのコツ

- **部署を増やす**: 必要な部署フォルダを追加して、`CLAUDE.md` と `_template.md` を作ります
- **部署を減らす**: 使わない部署フォルダは削除してOKです。`.company/CLAUDE.md` の組織図も合わせて更新してください
- **思考のDNA**: `.company/CLAUDE.md` の「判断スタイル」「禁止フレーズ」を自分の好みに書き換えてください。これが秘書・CEO・全部署の振る舞いを決めます
- **Notion等の外部連携**: 秘書のCLAUDE.mdに連携ルールを追記すれば、ファイル生成時にNotionにも記録するように拡張できます

---

## なぜ効くのですか？

普通にClaude Codeを使うと、毎回コンテキストがリセットされてしまいます。
`.company/` を置いておくと、

- 過去の決定が **意思決定ログ** として残ります → 「あの時なんでそう決めたっけ？」がなくなります
- TODOが **日次ファイル** で蓄積されます → 自分の働き方が可視化されます
- 壁打ちの結論が **メモ** に残ります → 同じ議論を繰り返さなくなります
- 秘書が窓口になります → 部署を意識しなくていいので、どこに何を保存するか迷いません

要するに、**Claude Codeに記憶と組織を持たせる仕組み**です。

---

## アンインストール / 戻し方

ワンライナーで入れた場合は、そのプロジェクトの `.company/` と `.claude/skills/company/` を削除すれば元に戻ります。

Mac / Linux:

```bash
rm -rf .company .claude/skills/company
```

Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force .company, .claude\skills\company
```

プラグインで入れた場合は、Claude Code内で:

```
/plugin uninstall company@dotcompany-template
/plugin marketplace remove sammyTI/dotcompany-template
```

---

## ライセンス

MIT

---

## 元ネタ

このテンプレートは [Shin-sibainu/cc-company](https://github.com/Shin-sibainu/cc-company) のコンセプトを参考に、6部署フル装備の配布版として再構成しました。ダッシュボードも同氏の cc-company-dashboard を fork しています。
