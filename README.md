<div align="center">

# 🔥 CareerForge — 接offer神器

[![Claude Code](https://img.shields.io/badge/Claude_Code-Skills-blueviolet?style=for-the-badge&logo=anthropic)](https://github.com/anthropics/claude-code)
[![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![Skills](https://img.shields.io/badge/Skills-5%2F5_Ready-blue?style=for-the-badge)](https://github.com/rebecha1227-a11y/CareerForge)

<br>

### 投了 100 份简历，回复的只有 3 个——你值得更好的方式。

<br>

*我知道你在海投中一次次刷新邮箱，在 Boss 直聘上一个个点「立即沟通」，*
*却换来一片已读不回的沉默。*
*简历石沉大海，面试不知道怎么准备，求职信写了删、删了写。我们都曾经历过。*

*没吃到时代红利的我们，如今可以吃一吃AI红利了——让 AI 帮你搜岗位、改简历、写求职信、模拟面试吧，*
*把你的时间花在真正重要的事上。*

<br>

**AI 驱动的求职全链路工具包** · 从岗位搜索到简历生成再到模拟面试 · 开源免费

兼容所有支持 Skills 的 AI Agent（Claude Code、Codex 等）

</div>

---

## 🆕 最近更新

**2026-06-09 · 岗位搜索支持全球求职**

感谢小红书网友们的反馈！`job-hunt` Skill 现在支持海外求职了：

- 🌏 **新增 7 大地区**：澳大利亚/新西兰、美国/加拿大、英国/欧洲、日本、韩国、新加坡/东南亚
- 🔍 **30+ 个求职平台**：Seek AU/NZ、Reed、Saramin、JobStreet、ZipRecruiter、Daijob 等，按地区智能推荐，用户多选
- 📋 **工签标注**：Excel 新增「签证/工签」列，自动识别 JD 中的 visa sponsorship 信息（✅ 提供担保 / ❓ 未标注 / ❌ 仅限本地）
- 🗣️ **多语言搜索**：海外地区英文关键词为主，同时中文覆盖华人社群招聘帖

> 在海外找工作的华人朋友们，现在可以直接用了 🎉

---

## 包含 5 个 Skill

| Skill | 功能 | 触发方式 |
|-------|------|----------|
| **job-hunt** | AI 岗位猎手，30+ 平台覆盖全球 10 个地区，支持签证担保筛选、多语言搜索、Boss 直聘联动，输出 Excel | `/job-hunt` 或 "帮我找工作" |
| **resume-match** | 简历 × JD 智能匹配分析，输出匹配度评分与优化建议 | `/resume-match` 或 "帮我分析简历匹配度" |
| **resume-craft** | 多模板简历生成与优化，7 种专业排版，输出 HTML + PDF | `/resume-craft` 或 "帮我做一份简历" |
| **cover-letter** | 求职信 & 招聘软件打招呼消息生成 | `/cover-letter` 或 "帮我写求职信" |
| **mock-interview** | 三轮 AI 模拟面试 + 逐题反馈报告 | `/mock-interview` 或 "帮我模拟面试" |

> 💡 每个 Skill 独立可用，也可串联使用：搜岗位 → 分析匹配度 → 优化简历 → 写求职信 → 模拟面试

---

## 安装

一条命令，自动适配你的 AI Agent——**不需要针对每个 Agent 单独安装**。

### 方式一：npx 一键安装（推荐 ⭐）

```bash
npx skills add rebecha1227-a11y/CareerForge
```

> 基于 [Vercel Skills CLI](https://github.com/vercel-labs/skills)，自动检测你安装了哪些 Agent（Claude Code、Codex、Cursor、Gemini CLI、Windsurf 等 **50+ 种**），一次安装全部搞定。
>
> 需要 Node.js 18+。没有 Node？用下面的方式二。

**指定安装到某个 Agent：**

```bash
npx skills add rebecha1227-a11y/CareerForge -a claude-code
npx skills add rebecha1227-a11y/CareerForge -a codex -a cursor
```

**全局安装（所有项目可用）：**

```bash
npx skills add rebecha1227-a11y/CareerForge -g
```

### 方式二：Shell 脚本安装

```bash
curl -sL https://raw.githubusercontent.com/rebecha1227-a11y/CareerForge/main/install.sh | bash
```

支持 Claude Code、Codex、Cursor、Gemini CLI、Trae、OpenCode、Rovo Dev，自动检测已安装的 Agent。

### 方式三：手动安装

```bash
git clone https://github.com/rebecha1227-a11y/CareerForge.git
cd CareerForge

# 复制到你的 Agent 的 skills 目录，例如 Claude Code：
cp -r skills/* ~/.claude/skills/

# 或 Codex：
cp -r skills/* ~/.codex/skills/
```

### 方式四：让 AI Agent 帮你装

直接把仓库链接发给你的 AI Agent：

> "帮我安装这个 Skill 包：https://github.com/rebecha1227-a11y/CareerForge"

### 安装后的文件结构

```
~/.claude/skills/           # 或你的 Agent 对应的 skills 目录
├── job-hunt/               # Skill 1：岗位搜索
│   └── SKILL.md
├── resume-match/           # Skill 2：匹配分析
│   ├── SKILL.md
│   └── references/
├── resume-craft/           # Skill 3：简历生成
│   ├── SKILL.md
│   ├── templates/          # 7 种 HTML 模板
│   ├── scripts/            # PDF 生成 & 照片处理
│   └── references/         # 设计规范
├── cover-letter/           # Skill 4：求职信
│   └── SKILL.md
└── mock-interview/         # Skill 5：模拟面试
    └── SKILL.md
```

### 可选依赖

| 依赖 | 用途 | 安装命令 |
|------|------|----------|
| Playwright | 后台生成 PDF（不装也能用浏览器导出） | `pip install playwright && playwright install chromium` |
| Pillow | 简历照片裁剪压缩 | `pip install Pillow` |
| openpyxl | 岗位搜索结果导出 Excel | `pip install openpyxl` |

---

## 使用流程

安装完成后，打开 Claude Code（或其他支持 Skills 的 AI Agent），用自然语言或斜杠命令触发对应 Skill。

### 🔍 Skill 1：岗位搜索（job-hunt）

```
你：/job-hunt（或"帮我找工作"、"搜一下合适的岗位"）
AI：请提供你的简历，或者告诉我你的职业方向
你：[上传简历]
AI：你想在哪里找工作？
    ① 中国大陆  ② 澳大利亚  ③ 新西兰  ④ 美国/加拿大
    ⑤ 英国  ⑥ 欧洲（德语区）  ⑦ 日本  ⑧ 韩国  ⑨ 新加坡/东南亚
你：澳大利亚，悉尼
AI：→ 从简历提取方向，确认搜索条件（城市、签证需求等）
   → 自动展开 10-20 组搜索关键词（海外地区英文关键词为主）
   → 根据目标地区选择平台（Seek、Indeed AU、LinkedIn、Jora...）
   → 并行搜索 30+ 平台覆盖全球（国内：Boss直聘、猎聘、智联…｜海外：LinkedIn、Indeed、Glassdoor…）
   → 如果有 Chrome MCP 插件，还能直接搜 Boss 直聘已保存的岗位分组
   → 搜索完成后，独立的质检 AI 逐条复核结果，剔除不匹配的、合并重复的
   → 输出 50-200+ 个匹配岗位（🟢高度匹配 / 🟡基本匹配 / 🟠可以尝试）
   → 海外岗位自动标注签证担保信息（✅提供担保 / ❓未标注 / ❌仅限本地）
   → 可导出 Excel 表格，带颜色标注和筛选器
   → 对感兴趣的岗位，一键跳转到匹配分析或写求职信
```

**输出效果：**

![岗位搜索 Excel 导出](docs/images/demo-output-jobhunt.png)

<details>
<summary><strong>💡 搜索需要登录的平台（Boss 直聘等）怎么办？三种方式任选</strong></summary>

<br>

岗位搜索默认走公开搜索引擎（Google/Bing），不需要登录任何平台就能搜到结果。但如果你想直接搜 **Boss 直聘、猎聘、拉勾**等需要登录的平台（数据更全、更新更快），有三种方式：

---

#### 方式一：Chrome 浏览器插件联动（推荐，最强大）

这是效果最好的方式——AI 直接在你已经登录好的浏览器里操作，就像有个助手帮你翻页面一样。

**你需要：**
- Chrome 浏览器 + [Claude Code Chrome 插件](https://chromewebstore.google.com/detail/claude-code/edfhcbmnidfdkgbcgbhcihmlopiaaapo)（免费）
- 在浏览器里提前登录好 Boss 直聘（或其他平台）

**使用步骤：**
1. 安装 Chrome 插件后，打开 Claude Code，它会自动检测到浏览器连接
2. 跟 AI 说：**"帮我搜一下 Boss 直聘上的岗位"**
3. AI 会在你的浏览器里自动搜索、翻页、提取岗位信息
4. 你只需要看着它操作就行，全程不需要手动干预

**进阶用法——批量提取已收藏的岗位：**

如果你平时在 Boss 直聘上收藏过岗位，或者建过搜索分组（比如"产品经理-深圳"），可以直接跟 AI 说：

> "我在 Boss 直聘上收藏了一些岗位，帮我全部提取出来分析一下"

AI 会自动打开你的收藏页面，滚动加载所有岗位（哪怕有几百个），然后按你的简历逐个做匹配筛选。省掉你一条条点开看的时间。

---

#### 方式二：导出 Cookies 给 AI（不需要装插件）

如果你不想装 Chrome 插件，可以把浏览器的登录 cookies 导出给 AI，它用这个临时凭证帮你搜索。

**你需要：**
- Chrome 浏览器 + [Cookie-Editor 插件](https://chromewebstore.google.com/detail/cookie-editor/hlkenndednhfkekhgcdicdfddnkalmdm)（免费，专门导出 cookies 的小工具）

**使用步骤：**
1. 在 Chrome 里打开 Boss 直聘，确保已经登录
2. 点击浏览器右上角的 Cookie-Editor 图标
3. 点击 **Export → Header String**，复制内容
4. 粘贴给 AI，跟它说：**"这是我的 Boss 直聘 cookies，帮我搜 XX 方向的岗位"**

> ⚠️ **安全提醒：** cookies 相当于临时登录凭证。AI 只在当次搜索中使用，不会保存到文件或代码里。但频繁抓取可能触发平台风控（比如要求重新登录），建议一天不要搜太多次。

---

#### 方式三：你搜，AI 帮你分析（零门槛）

最简单的方式，不需要装任何东西。

**使用步骤：**
1. 跟 AI 说你想找什么方向的工作
2. AI 会给你一批精心组合的**搜索关键词**（通常 10-20 组，覆盖各种叫法）
3. 你自己在 Boss 直聘上搜这些关键词
4. 把感兴趣的 JD **截图或复制文字**发给 AI
5. AI 帮你做匹配度分析 + 写打招呼消息

虽然需要你手动搜索，但 AI 帮你省掉了最费脑的部分——关键词怎么组合、简历和岗位到底匹不匹配、打招呼消息怎么写。

---

**三种方式对比：**

| | 方式一：Chrome 插件 | 方式二：Cookies | 方式三：手动搜 |
|---|---|---|---|
| 需要安装 | Chrome 插件 | Cookie-Editor 插件 | 无 |
| AI 自动化程度 | 全自动 | 半自动 | 手动搜+AI分析 |
| 能搜到的数据量 | 最大（支持分组提取） | 大 | 取决于你搜多少 |
| 上手难度 | ⭐ 简单 | ⭐⭐ 一般 | ⭐ 最简单 |
| 推荐场景 | 重度求职用户 | 偶尔搜一搜 | 随便看看机会 |

</details>

### 📊 Skill 2：简历匹配分析（resume-match）

```
你：/resume-match（或"帮我分析一下简历和 JD 的匹配度"）
AI：请提供你的简历和目标岗位 JD
你：[上传简历 + 粘贴 JD]
AI：→ 输出多维度匹配评分（硬技能、软技能、经验、教育等）
   → 匹配等级（S/A/B/C/D）
   → 逐项优化建议
   → 如果匹配度不够，可以一键跳转到 resume-craft 优化简历
```

**输出效果：**

![匹配分析报告](docs/images/demo-output-match.png)

### 📝 Skill 3：简历生成（resume-craft）

```
你：/resume-craft（或"帮我做一份简历"）
AI：你是想从零做一份新简历，还是优化已有简历？
你：从零做
AI：[通过对话收集你的经历、技能、教育等信息]
AI：推荐 3 种适合你的模板风格，你选哪个？
你：第一个
AI：→ 生成完整的 HTML 简历
   → 自动生成 PDF 文件
   → 内置导出按钮，也可以在浏览器中手动导出
```

**生成的简历效果：**

| Editorial 杂志编辑风 | Sidebar Navy 深蓝双栏 |
|:---:|:---:|
| ![Editorial 简历示例](docs/images/demo-resume-editorial.png) | ![Sidebar Navy 简历示例](docs/images/demo-resume-sidebar-navy.png) |

### 💌 Skill 4：求职信（cover-letter）

```
你：/cover-letter（或"帮我写一封求职信"）
AI：你是要写邮件投递的正式求职信，还是招聘软件上的打招呼消息？
你：邮件投递
AI：→ 基于你的简历和 JD，生成 300-500 字的求职信
   → 不是简历复述，而是讲故事、建立连接
   → 可以多轮修改，直到你满意
   → 支持中英文双语（不是翻译，是分别按各自文化习惯撰写）
```

**输出效果：**

| 邮件投递版 | 招聘软件打招呼版 |
|:---:|:---:|
| ![求职信-邮件版](docs/images/demo-output-cover1.png) | ![求职信-打招呼版](docs/images/demo-output-cover2.png) |

### 🎤 Skill 5：模拟面试（mock-interview）

```
你：/mock-interview（或"帮我模拟面试"）
AI：请提供目标岗位 JD 和你的简历
你：[提供材料]
AI：面试马上开始，一共三轮——

第一轮：HR 面试（5-6 题）
  → 考察求职动机、文化匹配、稳定性
  → 表面友好，但会在关键问题上追问

第二轮：业务主管面试（6-8 题）
  → 深挖项目经历（追问 2-3 层）
  → 情景题、压力面

第三轮：高管终面（4-5 题）
  → 开放性问题，看思维方式
  → 会提出反面论点要求回应

面试结束后 →
  → 综合评分 + 录用建议
  → 6 维度能力雷达图
  → 逐题详细反馈 + 个性化参考回答
  → 备考行动清单
```

**输出效果：**

| 总评 & 能力维度 | 逐题反馈 & 备考建议 |
|:---:|:---:|
| ![模拟面试报告1](docs/images/demo-output-interview1.png) | ![模拟面试报告2](docs/images/demo-output-interview2.png) |

---

## 7 种简历模板

![7种模板预览](docs/images/templates-overview.png)

| 编号 | 模板 | 风格 | 适合 |
|:---:|------|------|------|
| 01 | Editorial 杂志编辑风 | 经典文艺，奶油色底 | 创意 / 文化 / 教育 |
| 02 | Minimal 极简主义 | 纯白底，极少装饰 | 科技 / 设计 / 外企 |
| 03 | Sidebar Navy 深蓝双栏 | 左侧深蓝栏，信息密度高 | 技术 / 产品 |
| 04 | Sidebar Dark 深灰左栏 | 沉稳大气 | 管理 / 金融 / 咨询 |
| 05 | Dark Header 深色头部 | 顶部深色块，对比醒目 | 互联网 / 创业公司 |
| 06 | Clean Teal 清新青色 | 白底 + 青绿色条 | 万能模板 |
| 07 | Elegant 优雅对称 | 居中对称，衬线体 | 学术 / 高管 / 传统行业 |

所有模板支持自定义配色 —— 告诉 AI 你喜欢的颜色就行。

---

## 完整求职流程示例

```
第 1 步：搜岗位
  你："帮我找工作" 或 /job-hunt
  AI → 分析简历，展开 10-20 组关键词，搜 12+ 个平台
     → 输出 100+ 匹配岗位，导出 Excel
       ↓ 挑到感兴趣的岗位

第 2 步：分析匹配度
  你："帮我分析简历和这个 JD 的匹配度"
  AI → 评分 72 分（B 级），硬技能匹配但项目经验不够突出
       ↓ 建议优化简历

第 3 步：优化简历
  你："那帮我优化一下简历"
  AI → 自动衔接上一步的分析结果
     → 针对 JD 重写项目经历描述，突出匹配的关键词
     → 生成 HTML + PDF
       ↓ 简历搞定，准备投递

第 4 步：写求职信
  你："帮我写一封邮件求职信"
  AI → 基于优化后的简历 + JD，生成个性化求职信
     → 不是简历复述，突出独特价值
       ↓ 投递材料齐了，准备面试

第 5 步：模拟面试
  你："帮我模拟面试"
  AI → 三轮仿真面试（HR → 业务 → 高管）
     → 面试报告 + 逐题反馈 + 备考建议
       ↓ 上战场！
```

---

## License

MIT

---

> 用 AI 写代码做出来的 AI 求职工具，这就是 Vibe Coding ✨
