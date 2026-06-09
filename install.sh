#!/bin/bash

set -e

REPO="https://github.com/rebecha1227-a11y/CareerForge"
RAW="https://raw.githubusercontent.com/rebecha1227-a11y/CareerForge/main"
SKILLS="job-hunt resume-match resume-craft cover-letter mock-interview"

echo ""
echo "🚀 CareerForge — AI 求职工具包安装"
echo ""
echo "你用的是哪个 AI Agent？"
echo ""
echo "  1) Claude Code"
echo "  2) Codex CLI"
echo "  3) Cursor"
echo "  4) Gemini CLI"
echo "  5) Trae（国际版）"
echo "  6) Trae（国内版）"
echo "  7) OpenCode"
echo "  8) Rovo Dev"
echo "  9) 其他 / 不确定（安装到当前目录 ./skills/）"
echo ""
printf "请输入编号 [1-9]（默认 1）: "
read -r choice

case "${choice:-1}" in
  1) platform="claude-code"; dest="$HOME/.claude/skills" ;;
  2) platform="codex";       dest="$HOME/.codex/skills" ;;
  3) platform="cursor";      dest=".cursor/skills" ;;
  4) platform="gemini";      dest="$HOME/.gemini/skills" ;;
  5) platform="trae";        dest="$HOME/.trae/skills" ;;
  6) platform="trae-cn";     dest="$HOME/.trae-cn/skills" ;;
  7) platform="opencode";    dest=".opencode/skills" ;;
  8) platform="rovo-dev";    dest="$HOME/.rovodev/skills" ;;
  9) platform="generic";     dest="./skills" ;;
  *) echo "❌ 无效选项"; exit 1 ;;
esac

echo ""
echo "📦 安装到: $dest"
echo ""

mkdir -p "$dest"

for skill in $SKILLS; do
  echo "⬇️  安装 ${skill}..."
  if [ "$platform" = "generic" ]; then
    curl -sL "${RAW}/${skill}.skill" | tar -xz -C "$dest/"
  else
    src_dir="dist/$platform"
    # 尝试从本地 dist 目录复制（克隆仓库的用户）
    if [ -d "$src_dir" ]; then
      cp -r "$src_dir/".*"/skills/$skill" "$dest/" 2>/dev/null || \
      cp -r "$src_dir/"*"/skills/$skill" "$dest/"
    else
      # 从 GitHub 下载
      curl -sL "${RAW}/${skill}.skill" | tar -xz -C "$dest/"
    fi
  fi
done

echo ""
echo "✅ 安装完成！已安装 5 个 Skill："
echo ""
ls -1 "$dest/" | grep -E "^(job-hunt|resume-match|resume-craft|cover-letter|mock-interview)$" || ls -1 "$dest/"
echo ""

case "${choice:-1}" in
  1) echo "现在打开 Claude Code，说「帮我找工作」就能用了。" ;;
  2) echo "现在打开 Codex CLI，说「帮我找工作」就能用了。" ;;
  3) echo "现在打开 Cursor，在 Agent 模式下说「帮我找工作」就能用了。"
     echo "⚠️  需要先在 Settings → Beta 切换到 Nightly 频道，并启用 Agent Skills。" ;;
  4) echo "现在打开 Gemini CLI，说「帮我找工作」就能用了。"
     echo "⚠️  需要运行 /settings 启用 Skills 功能。" ;;
  *) echo "现在打开你的 AI Agent，说「帮我找工作」就能用了。" ;;
esac
echo ""
