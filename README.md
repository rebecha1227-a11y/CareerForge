# CareerForge — 接offer神器

![Claude Code](https://img.shields.io/badge/Claude_Code-Skills-blueviolet?style=flat-square&logo=anthropic)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Status](https://img.shields.io/badge/Status-Active_Development-orange?style=flat-square)
![Skills](https://img.shields.io/badge/Skills-2%2F4_Ready-blue?style=flat-square)

**AI 驱动的求职全链路工具包**，基于 Claude Code Skills 构建。从简历优化到模拟面试，让 AI 帮你拿到心仪的 offer。

---

## 包含什么

| Skill | 功能 | 状态 |
|-------|------|------|
| **resume-match** | 简历 × JD 智能匹配分析，输出匹配度评分与优化建议 | ✅ 可用 |
| **resume-craft** | 多模板简历生成与优化，支持 7 种专业排版风格，输出 HTML + PDF | ✅ 可用 |
| **cover-letter** | AI 生成求职信（Cover Letter） | 🚧 开发中 |
| **mock-interview** | AI 模拟面试，针对目标岗位定制问题 | 🚧 开发中 |

## 快速开始

### 1. 安装 Skill

将 `.skill` 文件放到你的项目目录，或在 Claude Code 中直接使用：

```bash
# 克隆仓库
git clone https://github.com/rebecha1227-a11y/CareerForge.git

# 在 Claude Code 中使用
cd CareerForge
claude
```

### 2. 使用 Skill

在 Claude Code 对话中，直接说出你的需求：

**简历匹配分析：**
> "帮我分析一下我的简历和这个 JD 的匹配度"

**简历生成：**
> "帮我做一份简历" / "帮我优化简历排版"

Claude 会自动触发对应的 Skill，通过对话引导你完成全流程。

## 简历模板预览

resume-craft 内置 7 种专业简历模板：

| 编号 | 模板 | 风格 | 适合 |
|------|------|------|------|
| 01 | Editorial 杂志编辑风 | 经典文艺，奶油色底 | 创意 / 文化 / 教育 |
| 02 | Minimal 极简主义 | 纯白底，极少装饰 | 科技 / 设计 / 外企 |
| 03 | Sidebar Navy 深蓝双栏 | 左侧深蓝栏，信息密度高 | 技术 / 产品 |
| 04 | Sidebar Dark 深灰左栏 | 沉稳大气 | 管理 / 金融 / 咨询 |
| 05 | Dark Header 深色头部 | 顶部深色块，对比醒目 | 互联网 / 创业公司 |
| 06 | Clean Teal 清新青色 | 白底+青绿色条 | 万能模板 |
| 07 | Elegant 优雅对称 | 居中对称，衬线体 | 学术 / 高管 / 传统行业 |

支持自定义配色——告诉 Claude 你喜欢的颜色即可。

## 依赖

- **Claude Code**（必需）
- **Playwright**（PDF 生成，可选）：`pip install playwright && playwright install chromium`
- **Pillow**（照片处理，可选）：`pip install Pillow`

## 项目结构

```
CareerForge/
├── resume-match.skill          # Skill 1：简历匹配（打包文件）
├── resume-match/               # Skill 1：源文件
│   └── skills/resume-match/
├── resume-craft.skill          # Skill 2：简历生成（打包文件）
├── resume-craft/               # Skill 2：源文件
│   └── skills/resume-craft/
│       ├── SKILL.md            # Skill 定义与对话流程
│       ├── templates/          # HTML 模板 & 预览页
│       ├── scripts/            # PDF 生成 & 照片处理脚本
│       └── references/         # 设计规范文档
├── test-output/                # 测试生成的示例简历
└── README.md
```

## License

MIT

---

> 用 AI 写代码做出来的 AI 求职工具，这就是 Vibe Coding 的魅力 ✨
