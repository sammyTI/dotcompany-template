# Claude Codeを会社化する仕組み

Claude Codeに、フォルダ一個、放り込むだけ。
中には、6部署のAIチーム。

**秘書 / CEO / マーケ / 開発 / 経理 / 営業**

あなたが話すのは、秘書ひとり。
指示が雑でも、6部署が勝手に補正します。

---

## これは何？

Claude Codeで「自分専用の仮想カンパニー」を運営するためのテンプレート。
`.company/` ディレクトリを自分のプロジェクトに置くだけで、Claude Codeが**6部署のAIチーム**として振る舞うようになる。

- **秘書**が常駐窓口。TODO管理、メモ、壁打ち、何でも受け付ける
- **CEO**が裏で部署振り分け。意思決定をログに残す
- **マーケ・開発・経理・営業**が必要に応じて動く
- 日々のメモ・決定・タスクは全て `.company/` 内のmdファイルに自動で蓄積される
- 1ヶ月後・1年後も、過去の判断と背景を秘書が思い出してくれる

---

## セットアップ（3ステップ）

### 1. 自分のプロジェクトに置く

```bash
# 既存プロジェクトに導入する場合
git clone https://github.com/sammyTI/dotcompany-template.git /tmp/dotcompany
cp -r /tmp/dotcompany/.company /path/to/your/project/

# またはサブモジュールとして
cd /path/to/your/project
curl -L https://github.com/sammyTI/dotcompany-template/archive/main.tar.gz | \
  tar xz --strip-components=1 dotcompany-template-main/.company
```

新規プロジェクトとして始めるなら、このリポジトリ自体をクローンしてそのまま使ってOK。

### 2. プロフィールを書く

`.company/CLAUDE.md` の **オーナープロフィール** セクションを自分の情報に書き換える。

- 名前・役職
- 事業・活動
- ミッション（短くてOK）
- 言語

これで秘書が「あなた専用」になる。

### 3. Claude Codeで起動

そのプロジェクトで Claude Code を開いて、こう言う:

```
.company/CLAUDE.md を読んで、秘書として動いてください
```

以降、何を言っても秘書が窓口になって対応する。

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

ユーザーは部署を意識しなくていい。秘書が判断して振り分ける。

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

各部署フォルダの `CLAUDE.md` に、その部署のルール・振る舞いが書かれている。
カスタマイズしたければそこを編集する。

---

## ファイル構成

```
.company/
├── CLAUDE.md               ← 組織全体のルール（最初にここを読む）
├── secretary/
│   ├── CLAUDE.md           ← 秘書の振る舞い
│   ├── inbox/              ← クイックメモ
│   ├── todos/              ← 日次TODO（YYYY-MM-DD.md）
│   └── notes/              ← 壁打ち・相談ログ
├── ceo/
│   ├── CLAUDE.md           ← 振り分けロジック
│   └── decisions/          ← 意思決定ログ
├── marketing/
│   ├── CLAUDE.md
│   ├── content-plan/       ← 記事・投稿の企画
│   └── campaigns/          ← キャンペーン管理
├── engineering/
│   ├── CLAUDE.md
│   ├── docs/               ← 技術ドキュメント
│   └── debug-log/          ← バグ調査ログ
├── finance/
│   ├── CLAUDE.md
│   ├── invoices/           ← 請求書
│   ├── expenses/           ← 経費
│   └── receipts/           ← レシート画像（処理前）
└── sales/
    ├── CLAUDE.md
    ├── clients/            ← クライアント情報
    └── proposals/          ← 提案書
```

各サブフォルダには `_template.md` が入っている。新規作成時はこれをコピーして使う。

---

## カスタマイズのコツ

- **部署を増やす**: 必要な部署フォルダを追加して `CLAUDE.md` と `_template.md` を作る
- **部署を減らす**: 使わない部署フォルダは削除してOK。`.company/CLAUDE.md` の組織図も合わせて更新
- **思考のDNA**: `.company/CLAUDE.md` の「判断スタイル」「禁止フレーズ」を自分の好みに書き換える。これが秘書・CEO・全部署の振る舞いを決める
- **Notion等の外部連携**: 秘書のCLAUDE.mdに連携ルールを追記すれば、ファイル生成時にNotionにも記録するようになる

---

## なぜこれが効くのか

普通にClaude Codeを使うと、毎回コンテキストがリセットされる。
`.company/` を置いておけば:

- 過去の決定が **意思決定ログ** として残る → 「あの時なんでそう決めたっけ？」がなくなる
- TODOが **日次ファイル** で蓄積される → 自分の働き方が可視化される
- 壁打ちの結論が **メモ** に残る → 同じ議論を繰り返さない
- 秘書が窓口 → 部署を意識しなくていい。どこに何を保存するか迷わない

要するに、**Claude Codeに記憶と組織を持たせる仕組み**。

---

## ライセンス

MIT

---

## 元ネタ

このテンプレートは [Shin-sibainu/cc-company](https://github.com/Shin-sibainu/cc-company) のコンセプトを参考に、6部署フル装備の配布版として再構成したもの。
