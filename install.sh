#!/bin/bash

set -e

SKILLS="resume-match resume-craft cover-letter mock-interview job-hunt"
REPO="https://github.com/rebecha1227-a11y/CareerForge/raw/main"

echo "🚀 CareerForge — 安装所有 Skills"
echo ""

mkdir -p skills

for skill in $SKILLS; do
  if [ -f "${skill}.skill" ]; then
    echo "📦 安装 ${skill}（本地文件）..."
    tar -xzf "${skill}.skill" -C skills/
  else
    echo "⬇️  下载并安装 ${skill}..."
    curl -sL "${REPO}/${skill}.skill" | tar -xz -C skills/
  fi
done

echo ""
echo "✅ 安装完成！已安装到 ./skills/ 目录："
echo ""
ls -1 skills/
echo ""
echo "现在可以打开 Claude Code（或其他支持 Skills 的 AI Agent），直接开始使用。"
