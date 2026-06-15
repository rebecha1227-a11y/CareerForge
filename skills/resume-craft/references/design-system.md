# CareerForge 设计规范 — 6 种简历模板

本文件定义了 6 种简历模板的视觉规范。生成 HTML 简历时，根据用户选择的模板风格，严格遵循对应规范。

视觉预览参考：`templates/CareerForge-模板预览.html`
结构代码参考：`templates/resume-template.html`（Editorial 风格的完整实现）

---

## 通用规范（所有模板共用）

### 纸张与页面

- 格式：A4（210mm × 297mm）
- 最大页数：2 页
- HTML 容器最大宽度：800px（屏幕预览用）

### 字号基准

| 元素 | 字号 |
|------|------|
| 姓名（中文） | 36px, font-weight: 700 |
| 姓名（英文拼音） | 15px, font-weight: 400 |
| 职位标题 | 17px, font-weight: 600 |
| Section 标题 | 15px, font-weight: 700 |
| 个人简介 | 14px, font-weight: 300, line-height: 1.7 |
| 工作/项目标题 | 15px, font-weight: 600 |
| 公司名 | 13.5px, font-weight: 300 |
| 日期 | 12px, font-style: italic |
| Bullet 正文 | 13px, font-weight: 300, line-height: 1.6 |
| 项目描述 | 13px, font-weight: 300 |
| 技能标签 | 10px, font-weight: 500 |
| 联系方式 | 13px, font-weight: 400 |
| 技能标签/内容 | 13px |

> 双栏模板（Sidebar Navy / Sidebar Dark）因空间有限，侧栏内文字可适当缩小 1-2px。

### 间距基准

| 元素 | 间距 |
|------|------|
| 页面上下边距 | 36px |
| 页面左右边距 | 44px |
| Section 间距 | 20-24px |
| Section 标题与内容间距 | 14px |
| Job/项目条目间距 | 16px |
| Bullet 条目间距 | 1-4px |
| 正文行高 | 1.55-1.7 |

### 照片规范

| 属性 | 单栏模板 | 双栏模板 |
|------|---------|---------|
| 位置 | Header 右上角 | 左侧栏顶部居中 |
| 尺寸 | 96px × 128px（3:4） | 50-52px 正方形 |
| 形状 | 圆角矩形 border-radius: 4px | 圆形 border-radius: 50% |
| 边框 | 1px solid var(--border) | 1.5px solid 对应色 |

### 导出按钮与编辑模式（所有模板必须包含）

- 固定在页面顶部的导出栏（`.export-bar`）
- 深色半透明背景
- **导出 PDF 按钮**：强调色按钮，点击调用 `window.print()`（浏览器原生打印，生成可选中、可搜索的真文字 PDF）
- **编辑模式按钮**（`.edit-btn`）：点击切换浏览器内直接编辑文字，再点退出编辑。按钮需要 `white-space: nowrap; flex-shrink: 0` 防止文字竖排
- 按钮旁提示文字：`⚠️ 打印对话框中请选：另存为 PDF → 纸张 A4 → 边距「无」→ 勾选「背景图形」`
- **不使用 html2pdf.js**（html2pdf.js 生成的是图片式 PDF，文字不可选中）

### 编辑模式样式

```css
.resume.editing {
  overflow: visible; /* 内容增多时自动撑开，不截断 */
}
```

编辑模式下用户可以直接修改简历文字，内容变多时下方板块自动往下排。打印时编辑按钮隐藏（`@media print { .edit-btn { display: none !important; } }`）。

### 导出与编辑 JS（所有模板通用）

```javascript
function toggleEdit() {
  var resume = document.querySelector('.resume');
  var btnText = document.getElementById('editBtnText');
  var isEditing = resume.contentEditable === 'true';
  if (isEditing) {
    resume.contentEditable = 'false';
    resume.classList.remove('editing');
    btnText.textContent = '编辑模式';
  } else {
    resume.contentEditable = 'true';
    resume.classList.add('editing');
    btnText.textContent = '退出编辑';
  }
}
function exportPDF() {
  var resume = document.querySelector('.resume');
  if (resume.contentEditable === 'true') {
    resume.contentEditable = 'false';
    resume.classList.remove('editing');
    document.getElementById('editBtnText').textContent = '编辑模式';
  }
  window.print();
}
```

### 打印样式（所有模板必须包含）

```css
@page {
  size: A4;
  margin: 0;
}

@media print {
  html, body {
    -webkit-print-color-adjust: exact !important;
    print-color-adjust: exact !important;
    background: [模板背景色] !important;
  }
  .export-bar { display: none !important; }
  .resume {
    margin: 0;
    box-shadow: none;
    max-width: 100%;
    background: [模板背景色];
  }
  .section { animation: none; }

  /* 分页控制 — .job 和 .section 允许跨页，避免大段空白 */
  .project-card, .edu-item, .skills-grid, .job-header {
    page-break-inside: avoid;
    break-inside: avoid;
  }
  /* 标题不能孤零零留在页底 */
  .section-title, .job-header {
    page-break-after: avoid;
    break-after: avoid;
  }
  .job-bullets li, .edu-details li, .summary, .project-desc {
    page-break-inside: avoid;
    break-inside: avoid;
  }

  /* 两页压缩：内容超出两页时，在此添加字号/间距缩小规则 */
  /* 正文字号不得低于 11px */
}
```

> `[模板背景色]` 替换为对应模板的背景色：Editorial `#faf9f7`、Minimal `#ffffff`、Sidebar Navy/Dark 主区 `#ffffff`、Dark Header `#ffffff`、Elegant `#fcfcfa`。

---

## 自定义配色

如果用户有自己喜欢的颜色，在选定模板的基础上替换强调色即可。替换时需同步调整：
- `--accent`：主强调色
- `--accent-light`：强调色的浅色版（用于标签底色等），通常取主色降低透明度或提亮
- 其他颜色（文字色、背景色、边框色）保持模板默认

常见替换示例：
| 颜色 | --accent | --accent-light |
|------|----------|----------------|
| 藏青 | `#2d4a7a` | `#e8eef6` |
| 深红 | `#8b3a3a` | `#f5e8e8` |
| 深紫 | `#5a3e7a` | `#f0e8f5` |
| 琥珀 | `#b8860b` | `#faf3e0` |
| 珊瑚 | `#cd5c5c` | `#fceaea` |

---

## 模板 01：Editorial 杂志编辑风

**关键词**：经典、文艺、温暖
**适合**：创意类、文化类、教育类岗位
**布局**：单栏

### 字体

```
Google Fonts: Playfair Display, Source Sans 3, Noto Serif SC, Noto Sans SC

--serif: 'Playfair Display', 'Noto Serif SC', serif;
--sans: 'Source Sans 3', 'Noto Sans SC', sans-serif;
```

- 标题/姓名/Section 标题：`var(--serif)`
- 正文/描述/Bullet：`var(--sans)`

### 配色

```css
:root {
  --ink: #1a1f2e;
  --ink-light: #4a5568;
  --ink-muted: #718096;
  --accent: #2d6b5f;
  --accent-light: #e8f4f0;
  --accent-warm: #d4a853;
  --cream: #faf9f7;
  --card: #ffffff;
  --border: #e2e0dc;
  --border-light: #f0eee9;
}
```

### 特征元素

- 页面背景：奶油色 `#faf9f7`
- 顶部装饰条：4px 高渐变（accent → accent-warm → accent）
- Section 标题：左侧 20px `accent-warm` 色横线 + 大写字母 + 4px 字间距
- 项目卡片：白色背景 + 左侧 3px `accent` 色边线
- Bullet 符号：▸（accent 色）

---

## 模板 02：Minimal 极简主义

**关键词**：克制、留白、专注内容
**适合**：科技类、设计类、外企
**布局**：单栏

### 字体

```
Google Fonts: DM Sans, Noto Sans SC

--sans: 'DM Sans', 'Noto Sans SC', sans-serif;
```

- 所有文字统一使用 `var(--sans)`，不使用衬线体
- 姓名加大加粗即可，不需要额外装饰

### 配色

```css
:root {
  --ink: #111111;
  --ink-light: #777777;
  --ink-muted: #cccccc;
  --accent: #111111;       /* 极简风用黑色作为强调 */
  --accent-light: #f5f5f5;
  --bg: #ffffff;
  --border: #e5e5e5;
  --border-light: #f5f5f5;
}
```

### 特征元素

- 页面背景：纯白 `#ffffff`
- 无顶部装饰条
- 分割线：0.5px `#e5e5e5`，非常细
- Section 标题：无装饰线，纯大写 + 字间距 3px，黑色
- 项目卡片：无背景色，底部 0.5px 分割线
- 技能标签：0.5px 边框，无背景色
- 职位标题下方小字用浅灰色 letter-spacing: 3px

---

## 模板 03：Sidebar Navy 深蓝双栏

**关键词**：结构化、信息密度高、专业
**适合**：技术类、产品类、需要展示大量技能的岗位
**布局**：双栏（左 34% 深蓝侧栏 + 右 66% 白底主区）

### 字体

```
Google Fonts: Outfit, Noto Sans SC

--sans: 'Outfit', 'Noto Sans SC', sans-serif;
```

- 全部无衬线体，现代感

### 配色

```css
/* 左侧栏 */
--sidebar-bg: #1e293b;
--sidebar-text: #cbd5e1;
--sidebar-heading: #60a5fa;
--sidebar-tag-bg: rgba(96, 165, 250, 0.15);
--sidebar-tag-text: #93c5fd;
--sidebar-border: #334155;

/* 右侧主区 */
--ink: #1e293b;
--ink-light: #64748b;
--ink-muted: #999999;
--accent: #60a5fa;
--bg: #ffffff;
--border: #eeeeee;
```

### 特征元素

- 左侧栏：深蓝 `#1e293b` 背景，放照片（圆形）、联系方式、技能标签、语言、教育
- 右侧主区：白底，放经历、项目
- 侧栏 Section 标题：蓝色 `#60a5fa`，大写 + 底部 0.5px 分割线
- 主区 Section 标题：深蓝色，底部 1px 分割线
- 技能标签：半透明蓝底
- 照片：50px 圆形，居中

---

## 模板 04：Sidebar Dark 深灰左栏

**关键词**：沉稳、大气、正式
**适合**：管理类、金融类、咨询类
**布局**：双栏（左 33% 深灰侧栏 + 右 67% 白底主区）

### 字体

```
Google Fonts: Outfit, Noto Sans SC

--sans: 'Outfit', 'Noto Sans SC', sans-serif;
```

### 配色

```css
/* 左侧栏 */
--sidebar-bg: #2c2c2c;
--sidebar-text: #cccccc;
--sidebar-heading: #999999;
--sidebar-tag-bg: rgba(255, 255, 255, 0.1);
--sidebar-tag-text: #dddddd;
--sidebar-border: #444444;

/* 右侧主区 */
--ink: #2c2c2c;
--ink-light: #666666;
--ink-muted: #999999;
--accent: #2c2c2c;        /* 用深灰本身作为强调 */
--bg: #ffffff;
--border: #eeeeee;
```

### 特征元素

- 左侧栏：深灰 `#2c2c2c` 背景
- 整体比 Sidebar Navy 更内敛，没有彩色强调
- 侧栏 Section 标题：浅灰 `#999`，底部分割线 `#444`
- 主区 Section 标题：深灰 `#2c2c2c`，加粗，底部分割线
- 技能标签：白色半透明底

---

## 模板 05：Dark Header 深色头部

**关键词**：醒目、现代、有冲击力
**适合**：互联网、创业公司、市场/运营类
**布局**：单栏，顶部深色块

### 字体

```
Google Fonts: DM Sans, Noto Sans SC

--sans: 'DM Sans', 'Noto Sans SC', sans-serif;
```

### 配色

```css
/* 头部区域 */
--header-bg: #1a1a2e;
--header-text: #ffffff;
--header-muted: rgba(255, 255, 255, 0.45);

/* 正文区域 */
--ink: #1a1a2e;
--ink-light: #555555;
--ink-muted: #888888;
--accent: #1a1a2e;
--accent-light: #f0f0f8;
--bg: #ffffff;
--border: #f0f0f0;
```

### 特征元素

- 头部：深色 `#1a1a2e` 大块背景，白色文字，放姓名+职位+联系方式（+可选照片）
- Section 标题：深色底 pill 形状（`display: inline-block; padding: 1.5px 8px; border-radius: 8px; background: #1a1a2e; color: #fff`）
- 项目卡片：底部 0.5px 分割线
- 技能标签：浅蓝灰底 `#f0f0f8`

---

## 模板 06：Elegant 优雅对称

**关键词**：精致、传统、学术感
**适合**：学术、高管、传统行业、法律/财务
**布局**：单栏，居中对称

### 字体

```
Google Fonts: Libre Baskerville, DM Sans, Noto Serif SC, Noto Sans SC

--serif: 'Libre Baskerville', 'Noto Serif SC', serif;
--sans: 'DM Sans', 'Noto Sans SC', sans-serif;
```

- 标题/姓名/Section 标题：`var(--serif)` 衬线体
- 正文/描述/Bullet/标签：`var(--sans)` 无衬线
- 整体以衬线体为主调

### 配色

```css
:root {
  --ink: #222222;
  --ink-light: #777777;
  --ink-muted: #999999;
  --accent: #222222;        /* 用深黑作为强调，不用彩色 */
  --accent-light: #f5f5f5;
  --bg: #fcfcfa;
  --border: #e8e6e2;
  --border-light: #d0ccc5;
}
```

### 特征元素

- 页面背景：微暖白 `#fcfcfa`
- 姓名：居中，大字间距 4px
- 职位：居中，斜体
- 联系方式：居中排列
- 头部底部：1.5px 实线分割
- Section 标题：居中 + 两侧装饰线（`::before` / `::after` 各一条水平线从两侧延伸）
- 项目卡片：白色背景 + 0.5px 边框，有 padding
- 技能标签：0.5px 边框 + 无背景
- 个人简介：居中对齐 + 斜体
