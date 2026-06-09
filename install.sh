#!/bin/bash
# CareerForge — AI 求职工具包安装脚本
# 自动检测已安装的 AI Agent 并安装 skills

set -e

REPO_RAW="https://raw.githubusercontent.com/rebecha1227-a11y/CareerForge/main"
SKILLS="job-hunt resume-match resume-craft cover-letter mock-interview"

echo ""
echo "🔥 CareerForge — AI 求职工具包"
echo ""

# Agent 配置：name|目录路径|检测方式
declare -a AGENTS=(
  "Claude Code|$HOME/.claude/skills|claude"
  "Codex CLI|$HOME/.codex/skills|codex"
  "Cursor|.cursor/skills|cursor"
  "Gemini CLI|$HOME/.gemini/skills|gemini"
  "Trae（国际版）|$HOME/.trae/skills|trae"
  "Trae（国内版）|$HOME/.trae-cn/skills|trae-cn"
  "OpenCode|.opencode/skills|opencode"
  "Rovo Dev|$HOME/.rovodev/skills|rovodev"
)

# 自动检测已安装的 agent
detected=()
for entry in "${AGENTS[@]}"; do
  IFS='|' read -r name dest cmd <<< "$entry"
  # 检查命令是否存在，或目录是否已存在
  if command -v "$cmd" &>/dev/null || [ -d "$(dirname "$dest")" ]; then
    detected+=("$name|$dest")
  fi
done

if [ ${#detected[@]} -eq 0 ]; then
  echo "未检测到已安装的 AI Agent。"
  echo ""
  echo "手动选择安装位置："
  echo ""
  for i in "${!AGENTS[@]}"; do
    IFS='|' read -r name dest cmd <<< "${AGENTS[$i]}"
    echo "  $((i+1))) $name"
  done
  echo "  9) 当前目录 ./skills/"
  echo ""
  printf "请输入编号: "
  read -r choice

  if [ "$choice" = "9" ]; then
    detected=("通用|./skills")
  else
    idx=$((choice-1))
    IFS='|' read -r name dest cmd <<< "${AGENTS[$idx]}"
    detected=("$name|$dest")
  fi
fi

echo "📦 检测到以下 Agent，将安装到："
echo ""
for entry in "${detected[@]}"; do
  IFS='|' read -r name dest <<< "$entry"
  echo "  ✓ $name → $dest"
done
echo ""

# 下载并安装
for entry in "${detected[@]}"; do
  IFS='|' read -r name dest <<< "$entry"
  mkdir -p "$dest"

  for skill in $SKILLS; do
    echo "⬇️  安装 $skill → $dest/$skill/"
    mkdir -p "$dest/$skill"

    # 下载 SKILL.md
    curl -sL "$REPO_RAW/skills/$skill/SKILL.md" -o "$dest/$skill/SKILL.md"

    # 下载附属文件（如果有的话）
    case "$skill" in
      resume-craft)
        mkdir -p "$dest/$skill/references" "$dest/$skill/scripts" "$dest/$skill/templates"
        curl -sL "$REPO_RAW/skills/$skill/references/design-system.md" -o "$dest/$skill/references/design-system.md" 2>/dev/null || true
        curl -sL "$REPO_RAW/skills/$skill/scripts/generate_pdf.py" -o "$dest/$skill/scripts/generate_pdf.py" 2>/dev/null || true
        curl -sL "$REPO_RAW/skills/$skill/scripts/process_photo.py" -o "$dest/$skill/scripts/process_photo.py" 2>/dev/null || true
        curl -sL "$REPO_RAW/skills/$skill/templates/resume-template.html" -o "$dest/$skill/templates/resume-template.html" 2>/dev/null || true
        curl -sL "$REPO_RAW/skills/$skill/templates/CareerForge-模板预览.html" -o "$dest/$skill/templates/CareerForge-模板预览.html" 2>/dev/null || true
        ;;
      resume-match)
        mkdir -p "$dest/$skill/references"
        curl -sL "$REPO_RAW/skills/$skill/references/scoring-guide.md" -o "$dest/$skill/references/scoring-guide.md" 2>/dev/null || true
        ;;
    esac
  done
  echo ""
done

echo "✅ 安装完成！已安装 5 个 Skill："
echo ""
echo "  📋 job-hunt        — 岗位搜索（30+ 平台，全球覆盖）"
echo "  📊 resume-match    — 简历匹配分析"
echo "  📝 resume-craft    — 简历生成（7 种模板）"
echo "  💌 cover-letter    — 求职信生成"
echo "  🎤 mock-interview  — 模拟面试（三轮）"
echo ""
echo "现在打开你的 AI Agent，说「帮我找工作」就能用了 🎉"
echo ""
