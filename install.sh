#!/usr/bin/env bash
# dotcompany-template installer
#
# Usage:
#   bash <(curl -fsSL https://raw.githubusercontent.com/sammyTI/dotcompany-template/main/install.sh)
#
# What it does:
#   1. Downloads the latest .company/ template from GitHub
#   2. Places it in the current directory
#   3. (Optional) Installs the /company slash command as a project-scope skill
#   4. Prints next steps

set -euo pipefail

REPO="sammyTI/dotcompany-template"
BRANCH="main"
TARBALL_URL="https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz"

# Colors
G="\033[32m"; Y="\033[33m"; R="\033[31m"; B="\033[1m"; N="\033[0m"

echo ""
echo -e "${B}🏢 dotcompany-template installer${N}"
echo "    Claude Codeに、フォルダ一個、放り込むだけ。"
echo ""

# Pre-check: does .company/ already exist here?
if [ -d "./.company" ]; then
  echo -e "${Y}⚠️  ./.company/ がすでに存在します。${N}"
  echo -n "上書きしますか？ (y/N): "
  read -r REPLY
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    echo "中断しました。"
    exit 0
  fi
  echo ""
fi

# Download tarball
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "📥 ダウンロード中: $TARBALL_URL"
if ! curl -fsSL "$TARBALL_URL" | tar xz -C "$TMPDIR"; then
  echo -e "${R}❌ ダウンロード失敗${N}"
  exit 1
fi

SRC="$TMPDIR/$(ls "$TMPDIR" | head -1)"

# Copy .company/
echo "📂 .company/ を配置中..."
rm -rf ./.company
cp -r "$SRC/.company" ./

# (Optional) Install project-scope skill so /company works without plugin install
echo -n "🤖 /company スラッシュコマンドをこのプロジェクトに有効化しますか？ (Y/n): "
read -r INSTALL_SKILL
if [[ ! "$INSTALL_SKILL" =~ ^[Nn]$ ]]; then
  mkdir -p .claude/skills
  rm -rf .claude/skills/company
  cp -r "$SRC/plugins/company/skills/company" .claude/skills/
  echo "   ✓ .claude/skills/company/ を配置（プロジェクト単位）"
fi

echo ""
echo -e "${G}✅ セットアップ完了${N}"
echo ""
echo -e "${B}次のステップ:${N}"
echo "  1. .company/CLAUDE.md を開いて「オーナープロフィール」を編集"
echo "  2. このプロジェクトで Claude Code を起動"
echo "  3. /company と入力 → 秘書ブリーフィング開始"
echo ""
echo -e "${B}グローバルにプラグインとして入れたい場合（任意・全プロジェクトで /company が使える）:${N}"
echo "  Claude Code 内で:"
echo "    /plugin marketplace add $REPO"
echo "    /plugin install company@dotcompany-template"
echo ""
echo -e "${B}ブラウザでダッシュボード:${N}"
echo "  cd $(pwd)"
echo "  npx --yes degit $REPO/packages/dashboard /tmp/dot-dash && cd /tmp/dot-dash && npm i && npm run build && node bin/cli.js"
echo ""
