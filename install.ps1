# dotcompany-template installer (Windows / PowerShell)
#
# Usage:
#   irm https://raw.githubusercontent.com/sammyTI/dotcompany-template/main/install.ps1 | iex
#
# What it does:
#   1. Downloads the latest .company/ template from GitHub
#   2. Places it in the current directory
#   3. (Optional) Installs the /company slash command as a project-scope skill
#   4. Prints next steps
#
# Requirements:
#   - Windows 10 1803+ (built-in tar.exe)
#   - PowerShell 5.1+ (Windows 10/11 default) or PowerShell 7+

$ErrorActionPreference = "Stop"
$repo = "sammyTI/dotcompany-template"
$branch = "main"
$tarballUrl = "https://github.com/$repo/archive/refs/heads/$branch.tar.gz"

Write-Host ""
Write-Host "🏢 dotcompany-template installer" -ForegroundColor Cyan
Write-Host "    Claude Codeに、フォルダ一個、放り込むだけ。"
Write-Host ""

# Pre-check
if (Test-Path ".\.company") {
    Write-Host "⚠️  ./.company/ がすでに存在します。" -ForegroundColor Yellow
    $reply = Read-Host "上書きしますか？ (y/N)"
    if ($reply -notmatch "^[Yy]$") {
        Write-Host "中断しました。"
        exit 0
    }
    Write-Host ""
}

# Make temp dir
$tmp = New-Item -ItemType Directory -Path (Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString()))

try {
    $tarFile = Join-Path $tmp.FullName "src.tar.gz"

    Write-Host "📥 ダウンロード中: $tarballUrl"
    Invoke-WebRequest -Uri $tarballUrl -OutFile $tarFile -UseBasicParsing

    Write-Host "📦 展開中..."
    tar -xzf $tarFile -C $tmp.FullName
    if ($LASTEXITCODE -ne 0) {
        throw "tar.exe による展開に失敗しました。Windows 10 1803以降が必要です。"
    }

    $src = Get-ChildItem -Directory $tmp.FullName | Where-Object { $_.Name -like "dotcompany-template-*" } | Select-Object -First 1
    if (-not $src) {
        throw "tarball の中身が見つかりません。"
    }

    Write-Host "📂 .company/ を配置中..."
    if (Test-Path ".\.company") {
        Remove-Item -Recurse -Force ".\.company"
    }
    Copy-Item -Recurse -Path (Join-Path $src.FullName ".company") -Destination ".\"

    Write-Host ""
    $reply = Read-Host "🤖 /company スラッシュコマンドをこのプロジェクトに有効化しますか？ (Y/n)"
    if ($reply -notmatch "^[Nn]$") {
        New-Item -ItemType Directory -Path ".\.claude\skills" -Force | Out-Null
        if (Test-Path ".\.claude\skills\company") {
            Remove-Item -Recurse -Force ".\.claude\skills\company"
        }
        Copy-Item -Recurse -Path (Join-Path $src.FullName "plugins\company\skills\company") -Destination ".\.claude\skills\"
        Write-Host "   ✓ .claude\skills\company\ を配置（プロジェクト単位）"
    }

    Write-Host ""
    Write-Host "✅ セットアップ完了" -ForegroundColor Green
    Write-Host ""
    Write-Host "次のステップ:"
    Write-Host "  1. .company\CLAUDE.md を開いて「オーナープロフィール」を編集"
    Write-Host "  2. このプロジェクトで Claude Code を起動"
    Write-Host "  3. /company と入力 → 秘書ブリーフィング開始"
    Write-Host ""
    Write-Host "グローバルにプラグインとして入れたい場合（任意・全プロジェクトで /company が使える）:"
    Write-Host "  Claude Code 内で:"
    Write-Host "    /plugin marketplace add $repo"
    Write-Host "    /plugin install company@dotcompany-template"
    Write-Host ""
}
finally {
    if (Test-Path $tmp.FullName) {
        Remove-Item -Recurse -Force $tmp.FullName -ErrorAction SilentlyContinue
    }
}
