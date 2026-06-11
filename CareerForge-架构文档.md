# CareerForge — AI 求职工具套件架构文档

> 最后更新：2026-06-11

## 1. 产品概述

CareerForge 是一套面向求职者的 AI Skill 工具组合，以 SKILL.md 形式运行在 Claude Code、Codex 等 50+ 种 AI Agent 平台上。覆盖从岗位搜索到 Offer 决策的完整求职链路，6 个 Skill 可独立使用也可串联协同。MIT 开源。

| 编号 | Skill | 名称 | 功能定位 |
|------|-------|------|----------|
| 1 | job-hunt | 岗位猎手 | 多平台搜索 + 匹配筛选 + Excel 导出，支持登录态搜索（Boss 直聘等） |
| 2 | resume-match | 简历匹配分析 | 简历 + JD → 六维度评分 + 匹配等级（A/B/C）+ 优化建议 |
| 3 | resume-craft | 简历生成与优化 | 从零生成或优化简历 → 7 种模板 → HTML + PDF 双格式输出 |
| 4 | cover-letter | 求职信撰写 | 邮件求职信（300-500 字）或招聘软件打招呼消息（80-150 字） |
| 5 | mock-interview | 模拟面试 | 三轮模拟面试（HR → 业务主管 → 高管）+ 逐题反馈报告 |
| 6 | offer-decision | Offer 决策官 | 多 Offer 六维度对比 + 薪资谈判话术 + 决策报告 |

### 核心设计原则

- **Skill 即 Markdown**：每个 Skill 就是一份 SKILL.md，AI Agent 读了就能干活，不依赖任何后端服务
- **渐进式披露（Progressive Disclosure）**：SKILL.md 只放流程骨架，资料性内容拆到 `references/` 按需加载，减少触发时的 token 消耗（详见「Token 优化架构」章节）
- **跨 Agent 兼容**：不绑定特定 AI 产品，支持 Claude Code、Codex、Cursor、Gemini CLI 等所有读得懂 Markdown 的 Agent
- **合规底线**：不做反爬绕过，岗位数据只走两条合规路径——用户登录态的浏览器控制 + 公开搜索引擎快照

---

## 2. 文件架构

```
CareerForge/
├── README.md                          ← 项目门面：6 个 Skill 说明、安装方式、使用流程、效果图
├── CareerForge-架构文档.md             ← 本文件
├── install.sh                         ← Shell 安装脚本（自动检测 Agent + 下载 Skill 文件）
├── .gitignore
│
├── skills/                            ← ★ 6 个 Skill 的正式版
│   │
│   ├── job-hunt/                      ← Skill 1：岗位猎手（360 行）
│   │   ├── SKILL.md                       流程骨架：信息收集→关键词展开→搜索→质检→输出
│   │   └── references/
│   │       ├── platforms-cn.md            中国大陆平台清单 + 搜索语法
│   │       ├── platforms-global.md        海外 9 地区平台清单 + 搜索语法
│   │       ├── login-platforms.md         Boss 直聘等登录态搜索教程（三种方式 + 环境探测）
│   │       └── excel-export.md            Excel 导出规范（14 列 + openpyxl 代码）
│   │
│   ├── resume-match/                  ← Skill 2：简历匹配分析（188 行）
│   │   ├── SKILL.md                       六维度评分 + 匹配等级 + 优化建议
│   │   └── references/
│   │       ├── scoring-guide.md           六维度详细评分标准
│   │       └── report-spec.md             HTML 报告设计规范
│   │
│   ├── resume-craft/                  ← Skill 3：简历生成与优化（254 行）
│   │   ├── SKILL.md                       路径 A 从零生成 / 路径 B 优化已有简历
│   │   ├── references/
│   │   │   └── design-system.md           7 种模板的字体/配色/布局详细规范（445 行）
│   │   ├── templates/
│   │   │   ├── resume-template.html       Editorial 风格完整 HTML 模板（含导出按钮、打印 CSS）
│   │   │   └── CareerForge-模板预览.html   7 种模板的视觉预览页
│   │   └── scripts/
│   │       ├── generate_pdf.py            Playwright HTML → PDF 转换
│   │       └── process_photo.py           照片裁剪/压缩/Base64（PIL）
│   │
│   ├── cover-letter/                  ← Skill 4：求职信撰写（197 行）
│   │   └── SKILL.md                       场景 A 邮件投递 / 场景 B 招聘软件打招呼
│   │
│   ├── mock-interview/                ← Skill 5：模拟面试（140 行）
│   │   ├── SKILL.md                       信息收集 + 准备阶段 + 面试行为规则
│   │   └── references/
│   │       ├── interview-questions.md     三轮面试出题规则 + 深挖逻辑 + 压力面示例
│   │       └── report-spec.md             面试报告结构 + HTML 报告设计规范
│   │
│   └── offer-decision/                ← Skill 6：Offer 决策官（239 行）
│       ├── SKILL.md                       六维度对比 + 经济价值计算 + 决策建议
│       └── references/
│           ├── negotiation-scripts.md     薪资谈判锚点 + 三套话术场景
│           └── report-spec.md             HTML 决策报告设计规范
│
├── docs/
│   └── images/                        ← README 用的效果图（demo 截图、模板预览图）
│
├── test-output/                       ← 拟真测试数据（gitignore 排除）
│   ├── 陈明远-*.html                      各 Skill 的标杆 demo 输出
│   ├── 苏婉清-*.html
│   └── 岗位搜索结果_*.xlsx                job-hunt 的 Excel 导出样本
│
└── 智联AI创新大赛/                     ← 比赛材料（gitignore 排除）
```

### 文件统计

| 类别 | 文件数 | 总行数 |
|------|--------|--------|
| SKILL.md（6 个） | 6 | ~1,378 行 |
| references/（11 个） | 11 | ~1,315 行 |
| templates + scripts | 4 | — |
| **合计 Skill 相关** | **21** | **~2,693 行** |

---

## 3. Token 优化架构（渐进式披露）

### 问题

6 个 SKILL.md 如果全文加载进上下文，串联使用 4 个 Skill 时累计约 28K tokens，挤占实际干活（简历分析、岗位搜索）的空间。

### 解决方案

将每个 Skill 拆分为两层：

```
SKILL.md（流程骨架，常驻上下文）
  └── references/（资料性内容，按需加载）
        ├── 平台清单、搜索语法
        ├── 出题规则、话术脚本
        ├── HTML 报告设计规范
        └── 评分标准、Excel 格式定义
```

**SKILL.md 中用强制性措辞指引加载**，例如：
- 「执行搜索前，**必须先读取** references/platforms-cn.md」
- 「生成报告前，**必须先读取** references/report-spec.md」

### 效果

| Skill | 优化前 | 优化后（SKILL.md） | 节省 | 按需加载时机 |
|-------|--------|-------------------|------|-------------|
| job-hunt | ~13K tokens | ~4K | 69% | 搜索时按地区加载 |
| mock-interview | ~7.3K | ~3.5K | 52% | 面试时加载题库，出报告时加载规范 |
| offer-decision | ~5.5K | ~3K | 45% | 谈薪时加载话术，生成报告时加载规范 |
| resume-match | ~5.2K | ~3.7K | 29% | 生成 HTML 报告时加载规范 |
| resume-craft | ~6.1K | ~6.1K | — | 已有 design-system.md |
| cover-letter | ~3.6K | ~3.6K | — | 体积小，不拆 |
| **串联 4 Skill** | **~28K** | **~14K** | **50%** | — |

---

## 4. 六个 Skill 详解

### 4.1 job-hunt（岗位猎手）

**目标**：一轮搜索产出 50-100 个匹配岗位，按匹配度分为 🟢🟡🟠 三档。

**完整流程**：

```
信息收集（简历 + 目标地区 + 城市 + 平台选择）
    │
    ├── 用户选了登录态平台（Boss 直聘等）
    │   └── 立刻读取 login-platforms.md → 引导浏览器控制/cookies/手动搜索
    │
    ▼
关键词语义展开（10-20 组，岗位名变体 + 中英互译 + 上下游 + 技能反搜）
    │
    ▼
并行搜索（每组关键词 × 多平台，WebSearch + 登录态）
    │  ├── 时效过滤：追加 after:YYYY-MM-DD，日期信号缺失最高只能到 🟡
    │  └── 登录态数据作为结果主体，WebSearch 快照作为补充
    │
    ▼
质检 subagent（独立上下文，不受搜索过程干扰）
    │  ├── 🟢 全量验证：3-5 个并行 WebFetch，确认链接存活
    │  ├── 🟡 不主动验证，标注「⏳ 时效未确认」
    │  ├── 抽查 🟡 的 20-30%，升/降级
    │  └── 去重 + 数据完整性检查
    │
    ▼
输出（对话内分档展示 + 可选 Excel 导出）
```

**登录态搜索（三种方式，按环境能力探测）**：

| 方式 | 前提 | 体验 |
|------|------|------|
| A. 浏览器控制 MCP | Claude in Chrome / Codex for Chrome / Playwright MCP | 最好，AI 直接在用户浏览器里操作 |
| B. Cookies 导入 | 能执行 Python/网络请求 | 可用，有小概率触发平台风控 |
| C. 用户手动搜索 | 无 | 兜底，AI 辅助整理 |

**关键规则**：
- 禁止默默降级——检测不到浏览器控制时，先推荐装插件，让用户二选一
- Boss 直聘 JS 选择器会过时——如果字段大量为空，用 `textContent` 全文兜底 + AI 解析

**Excel 导出**：14 列，openpyxl 生成，条件行着色，冻结首行 + 自动筛选器，支持追加模式。

---

### 4.2 resume-match（简历匹配分析）

**输入**：简历 + JD

**六维度评分**（满分 100，加权计算）：

| 维度 | 权重 |
|------|------|
| 硬性技能匹配度 | 25% |
| 工作经验相关度 | 25% |
| 软性能力匹配度 | 15% |
| 教育背景匹配度 | 10% |
| 关键词覆盖率 | 15% |
| 简历质量 | 10% |

**匹配等级**：
- A. Strong Fit（≥75 分）：建议申请，微调措辞
- B. Stretch Fit（50-74 分）：可以申请，需重新包装经历
- C. Poor Fit（<50 分）：差距大，给出补足路径和替代方向

**输出**：对话内结构化报告 → 可选生成 HTML 可视化报告 → 引导衔接 resume-craft

---

### 4.3 resume-craft（简历生成与优化）

**两条路径**：
- 路径 A：从零生成（六轮对话收集信息，含深挖/Grill 机制）
- 路径 B：优化已有简历（读取 → 确认优化方向 → 选模板 → 生成）

**7 种模板**：

| 编号 | 模板名称 | 布局 | 适用场景 |
|------|---------|------|---------|
| 01 | Editorial 杂志编辑风 | 单栏 | 创意/文化类 |
| 02 | Minimal 极简主义 | 单栏 | 科技/设计/外企 |
| 03 | Sidebar Navy 深蓝双栏 | 双栏 | 信息密度高的岗位 |
| 04 | Sidebar Dark 深灰左栏 | 双栏 | 管理/金融类 |
| 05 | Dark Header 深色头部 | 单栏 | 通用 |
| 06 | Clean Teal 清新青色 | 单栏 | 大部分岗位 |
| 07 | Elegant 优雅对称 | 单栏 | 学术/高管/传统行业 |

**输出**：HTML 文件（内置 `window.print()` 导出按钮）+ PDF 文件（Playwright 后台生成）

**排版硬性规则**：严格两页以内（A4）、正文字号 ≥ 11px、section 间距 20-24px、行高 1.55-1.7

**深挖（Grill）机制**：第四轮收集经历时，对照 JD 追问细节、引导换角度描述、建议更好表述。每段经历最多追问 2-3 次，不变成审讯。

---

### 4.4 cover-letter（求职信撰写）

**两种场景**：
- 场景 A：邮件投递 → 完整信件格式（开场 + 核心匹配 + 独特价值 + 收尾），300-500 字
- 场景 B：招聘软件打招呼 → 精简消息（身份 + 核心优势 + 期待），80-150 字

**核心原则**：Cover Letter ≠ 简历复述。讲故事、建连接、展示简历里看不到的特质。

**输出**：纯文本，直接在对话中呈现（不生成 HTML/PDF）。支持中英文双语。

---

### 4.5 mock-interview（模拟面试）

**三轮面试**：

| 轮次 | 角色 | 题量 | 考察重点 |
|------|------|------|---------|
| 第一轮 | HR | 5-6 题 | 求职动机、文化匹配、稳定性、薪资期望 |
| 第二轮 | 业务主管 | 6-8 题 | 专业能力、项目经验、技术深度 |
| 第三轮 | 高管 | 4-5 题 | 战略思维、学习能力、成长潜力 |

**真实感设计**：
- 一题一题问，回答后不给评价（模拟真实面试）
- 每轮至少 2 题追问，追问最多 3 层
- 每轮 1-2 个压力面问题，针对简历弱项
- 节奏有松有紧，开场暖、中间紧、结尾缓
- 如提供公司名，会搜索真实面经融入题库

**面试报告**：综合评分 + 各轮逐题反馈（原始回答 + 评分 + 优点 + 不足 + 参考回答）+ 能力雷达图 + 备考建议。可输出为 HTML 报告。

---

### 4.6 offer-decision（Offer 决策官）

**六维度对比模型**：

| 维度 | 默认权重 | 说明 |
|------|----------|------|
| 💰 经济价值 | 25% | 年度总包 + 税后到手 + 实际时薪 + 隐性成本 |
| 📈 成长价值 | 20% | 学习机会、晋升空间、leader 水平 |
| 🏢 平台价值 | 15% | 公司品牌、简历加分 |
| 🚀 赛道价值 | 15% | 行业前景、3-5 年发展潜力 |
| ⚖️ 生活质量 | 15% | 工作强度、通勤、假期 |
| 🛡️ 安全边际 | 10% | 裁员风险、试用期条件 |

权重根据用户偏好（最看重什么）动态调整。

**经济价值计算**：年度总包 / 税后月到手 / 实际时薪 / 城市购买力，含隐性成本（通勤、无偿加班、大小周折算）。

**输出四部分**：
1. Offer 对比总览（表格）
2. 六维度评分 + 雷达图
3. 薪资谈判作战室（按需，含三套话术场景）
4. 决策建议（推荐哪个 + 原因 + 注意事项）

可生成 HTML 可视化决策报告。

---

## 5. Skill 间协同

6 个 Skill 可串联成完整求职工作流，同一对话中后续 Skill 自动复用前面已提取的信息：

```
[job-hunt] 搜索岗位
    │
    ▼ 选中岗位
[resume-match] 匹配度分析
    │
    ├── A/B 级 ──→ [cover-letter] 写求职信 ──→ [mock-interview] 模拟面试
    │
    └── B/C 级 ──→ [resume-craft] 优化简历 ──→ 重新匹配
                                                    │
                                                    ▼ 拿到 offer
                                              [offer-decision] 决策 + 谈薪
```

也可以任意跳跃使用，不强制按顺序。

---

## 6. 安装体系

### 方式一：npx 一键安装（推荐）

```bash
npx @anthropic-ai/skills add rebecha1227-a11y/CareerForge
```

基于 Vercel Skills CLI，自动检测已安装的 Agent（Claude Code、Codex、Cursor、Gemini CLI 等 50+ 种），一次安装全部搞定。

### 方式二：Shell 脚本安装

```bash
curl -sL https://raw.githubusercontent.com/rebecha1227-a11y/CareerForge/main/install.sh | bash
```

`install.sh` 的工作流程：

1. **Agent 自动检测**：遍历 8 个已知 Agent（Claude Code / Codex / Cursor / Gemini CLI / Trae 国际版+国内版 / OpenCode / Rovo Dev），通过命令行检查或目录检查判断是否安装
2. **未检测到时**：展示手动选择菜单
3. **下载 Skill 文件**：对每个检测到的 Agent，依次下载 6 个 SKILL.md 及其附属文件（references/、templates/、scripts/）到对应的全局 skills 目录
4. **附属文件通过 case 分支处理**：每个 Skill 有独立的 case 分支，精确下载该 Skill 需要的 references 文件

### 方式三：手动安装

Git clone 仓库后，把 `skills/` 目录下的文件夹复制到对应 Agent 的全局 skills 目录。

| Agent | 全局 Skills 目录 |
|-------|-----------------|
| Claude Code | `~/.claude/skills/` |
| Codex | `~/.codex/skills/` |
| Cursor | `.cursor/skills/`（项目级） |
| Gemini CLI | `~/.gemini/skills/` |

---

## 7. 技术要点

### 7.1 浏览器控制集成（job-hunt）

job-hunt 的登录态搜索依赖浏览器控制能力，设计为跨 Agent 兼容：

- **能力探测优先于产品绑定**：不写死「Claude Code 用 XXX」，而是检测当前环境有没有浏览器控制工具
- **三种浏览器插件等价支持**：
  - Claude Code 用户 → Claude in Chrome 插件
  - Codex 用户 → Codex for Chrome 插件
  - 其他 Agent → Playwright MCP 等
- **禁止默默降级**：检测不到浏览器控制时，必须先向用户展示安装插件的选项，不能直接跳到 cookies 方案

Boss 直聘 JS 提取代码（核心逻辑）：

```javascript
const cards = document.querySelectorAll('.job-card-wrap');
cards.forEach(c => {
    jobs.push({
        title: c.querySelector('.job-name')?.textContent?.trim(),
        salary: c.querySelector('.job-salary')?.textContent?.trim(),
        company: c.querySelector('.boss-name')?.textContent?.trim(),
        link: c.querySelector('a[href*="job_detail"]')?.href
    });
});
```

**选择器防腐化**：招聘网站改版频繁，如果选择器取到大量空值，兜底用 `c.textContent` 全文交给 AI 解析。

### 7.2 时效防线（job-hunt）

WebSearch 搜到的是搜索引擎快照，岗位可能早已下架。三层防线：

1. **搜索时**：每组关键词追加 `after:YYYY-MM-DD`（30 天内），从源头过滤
2. **评级时**：看不到日期信号的岗位最高只能到 🟡，标注「⏳ 时效未确认」
3. **质检时**：🟢 岗位全量并行验证（3-5 个一批 WebFetch），确认链接存活

登录态实时抓取的数据默认在招，跳过时效验证。

### 7.3 简历模板系统（resume-craft）

**设计规范集中管理**：`references/design-system.md`（445 行）定义了 7 种模板的完整规范：

- 每种模板的字体搭配（Google Fonts）
- 配色方案（CSS 变量：`--accent`、`--accent-light`、`--bg` 等）
- 布局规则（单栏/双栏、间距、分页控制）
- 支持用户自定义配色（替换 `--accent` 变量）

**HTML 导出 PDF**：

两种方式并存：
1. **后台生成**：`scripts/generate_pdf.py` 调用 Playwright，零交互出 PDF
2. **前端导出**：HTML 内置 `window.print()` 按钮，用户自行打印为 PDF

两种方式底层都是 Chrome 打印引擎，生成真文字 PDF（可选中、可搜索、可被 HR 系统 ATS 解析）。

关键 CSS 规则：
```css
@page { size: A4; margin: 0; }
@media print {
    .export-bar { display: none; }
    print-color-adjust: exact;
}
```

分页控制：section 和 job 允许跨页（避免大段空白），project-card 和 job-header 禁止截断。

**照片处理**：`scripts/process_photo.py` 用 PIL 裁剪为 3:4 比例、压缩、转 base64 嵌入 HTML。

### 7.4 Excel 导出系统（job-hunt）

使用 openpyxl 生成 `.xlsx`，14 列结构：

编号 / 匹配度 / 岗位名称 / 公司 / 城市 / 薪资 / 经验要求 / 发布日期 / 匹配点 / 签证工签 / 标签 / 来源平台 / 链接 / 备注

格式规范：
- 表头：加粗白字 + 蓝色背景（#4472C4）
- 🟢 行：浅绿底（#E8F5E9）
- 🟡 行：浅黄底（#FFF8E1）
- 🟠 行：浅橙底（#FFF3E0）
- 冻结首行 + 自动筛选器
- 支持追加模式（load_workbook + 自动去重 + 编号接续）

### 7.5 质检 subagent 架构（job-hunt）

搜索完成后启动独立的质检 subagent，在干净的上下文中做最后一轮把关：

- **输入**：初步分级的岗位列表 + 用户简历核心画像
- **🟢 全量检查**：标题匹配度、技能覆盖率、经验年限、硬性要求、链接有效性
- **🟡 抽查 20-30%**：发现被低估的好岗位升级，不相关的降级
- **并行验证（强制）**：3-5 个链接一批并行 WebFetch，禁止逐条串行
- **输出**：质检摘要（升/降级统计 + 移除统计 + 最终数量）

### 7.6 HTML 报告系统（resume-match / mock-interview / offer-decision）

三个 Skill 都可选输出 HTML 可视化报告，各自在 `references/report-spec.md` 中定义设计规范。共同特征：

- 单文件 HTML，所有 CSS 内联，无外部依赖
- 深色主题（`--ink: #1a1a2e` 等 CSS 变量）
- 卡片式布局
- 雷达图（SVG 内联绘制）
- 响应式设计

---

## 8. 依赖与环境

| 依赖 | 用途 | 哪个 Skill 用 | 必须？ |
|------|------|--------------|--------|
| openpyxl (Python) | Excel 导出 | job-hunt | 导出 Excel 时需要 |
| Playwright (Python) | HTML → PDF | resume-craft | 后台生成 PDF 时需要 |
| Pillow / PIL (Python) | 照片处理 | resume-craft | 简历放照片时需要 |
| Chrome 浏览器插件 | 登录态搜索 | job-hunt | 方式 A 需要，非强制 |
| WebSearch 工具 | 公开搜索 | job-hunt | 免登录搜索需要 |
| WebFetch 工具 | 链接验证 | job-hunt | 质检验证需要 |

所有依赖都是可选的——没有也不影响 Skill 触发，AI 会在需要时提示用户安装。

---

## 9. 安全与合规

### 红线规则（所有 Skill 共享）

- **诚实原则**：不编造经历、不抬高资历、不虚构动机、不给万能模板答案
- **不自动投递**：只搜索和展示岗位，投递由用户自己完成
- **不存储凭证**：Cookies 仅临时使用，不写入代码、不存入文件
- **不做反爬**：不伪装请求、不破解验证码、不绕过平台安全机制
- **隐私保护**：用户简历中的手机号、邮箱等个人信息不被缓存或泄露

### 合规路径（job-hunt）

岗位数据获取只走两条路：
1. **用户登录态 + 浏览器控制**：用户访问自己账号的数据，AI 辅助记录
2. **公开搜索引擎快照**：WebSearch 搜索公开索引的招聘页面

---

## 10. Skill 间数据传递

同一对话中串联使用多个 Skill 时，后续 Skill 自动复用前面已有的信息：

| 数据 | 来源 Skill | 消费 Skill |
|------|-----------|-----------|
| 简历内容（解析后的结构化信息） | 任意第一个使用的 Skill | 所有后续 Skill |
| JD 解析结果 | resume-match / job-hunt | cover-letter / mock-interview |
| 匹配度分析（强项/弱项） | resume-match | mock-interview（弱项作为面试重点）/ cover-letter（强项作为亮点） |
| 优化后的 Markdown 简历 | resume-match | resume-craft（直接生成 HTML+PDF） |
| 选中的岗位 JD | job-hunt | resume-match / cover-letter / mock-interview |
| Offer 信息 | mock-interview（面试后拿到 offer） | offer-decision |

---

## 11. 用户体验原则

1. **不要一次问太多**：每次最多 2-3 个问题，分批收集
2. **先看效果再看代码**：改完直接跑起来，不讲架构
3. **小步快跑**：一次改一点，看对不对，再改下一步
4. **给出示例引导**：特别是工作经历描述，给「好 vs 一般」的对比
5. **即时反馈**：生成后主动问「哪里需要调整」
6. **尊重用户选择**：不强推功能，用户只想做面试练习就不推简历优化
