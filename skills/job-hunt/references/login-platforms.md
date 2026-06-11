# 需登录平台搜索教程（Boss 直聘、拉勾等）

> 用户选中 Boss 直聘、拉勾等需登录平台时，必须读取本文件。

## 环境能力探测（先做这一步）

三种方式按当前 AI 环境的能力依次选择，**按能力探测，不绑定特定 AI 产品**（Claude Code、Codex 或其他支持 MCP 的 agent 都适用）：

1. 当前环境有**浏览器控制工具**（Claude in Chrome 插件、Codex for Chrome 插件、Playwright MCP、Chrome DevTools MCP 等）→ 方式 A（体验最好，平台无感知）
2. 没有浏览器控制，但能执行 Python/网络请求 → 方式 B（cookies 导入）
3. 都没有 → 方式 C（用户手动搜索 + AI 辅助整理）

**禁止默默降级**：探测不到浏览器控制工具时，不要直接进入方式 B，必须先告诉用户可以装浏览器插件升级体验，让用户二选一：

> 「我当前没有浏览器控制权限。两个选择：
> A. **装个浏览器插件（推荐，一劳永逸）**：装好后我能直接在你登录的浏览器里搜索，实时数据、无风控风险
>    - Claude Code 用户 → Chrome 商店搜「Claude in Chrome」
>    - Codex 用户 → Chrome 商店搜「Codex」（Codex for Chrome 官方插件）
>    - 其他 agent → 配置 Playwright MCP 等浏览器控制 MCP
> B. **不想装** → 走 cookies 导入，需要装 Cookie-Editor 插件复制一段内容给我，有小概率触发平台风控
>
> 选哪个？」

合规边界：方式 A/B 都是用户访问自己有权查看的账号数据，不涉及破解平台反爬机制（伪装机器人、破解验证码等一律不做）。

## 方式 A：浏览器控制 MCP 辅助（推荐）

如果当前环境有浏览器控制工具：
1. 确认用户已在浏览器中登录目标平台
2. 通过浏览器控制工具在用户浏览器中操作（以下以 Chrome MCP 工具名为例，其他浏览器 MCP 用对应的导航/点击/执行 JS 工具即可）
3. 支持两种搜索模式：

**模式 1：关键词搜索**
- 导航到搜索页（如 `https://www.zhipin.com/web/geek/jobs?query=关键词&city=城市代码`）
- 等待页面加载（`wait(3)`）
- 用 `get_page_text` 提取岗位列表

**模式 2：用户已有分组搜索（推荐，数据量大）**

Boss 直聘等平台允许用户保存岗位分组。如果用户已有分组：

```
步骤 1：导航到分组
- navigate 到 https://www.zhipin.com/web/geek/jobs
- wait(2) 等页面加载
- find 查找用户指定的分组名称（如"软件项目经理"）
- left_click 点击分组标签

步骤 2：滚动加载全部岗位
Boss 直聘是懒加载的，必须反复滚动到页面底部才能加载全部岗位：

javascript_exec:
  // 反复滚动直到没有新岗位加载
  let prev = 0;
  function scrollAll() {
      return new Promise(resolve => {
          const interval = setInterval(() => {
              window.scrollTo(0, document.body.scrollHeight);
              const current = document.querySelectorAll('.job-card-wrap').length;
              if (current === prev) {
                  clearInterval(interval);
                  resolve(current);
              }
              prev = current;
          }, 2000);
      });
  }
  scrollAll()

注意：一个分组可能有 300-500+ 个岗位，需要多轮滚动（每轮加载约 15 个）。

步骤 3：批量提取岗位数据
用 JavaScript 一次性提取所有岗位卡片的结构化信息：

javascript_exec:
  const cards = document.querySelectorAll('.job-card-wrap');
  const jobs = [];
  cards.forEach(c => {
      const footerText = c.querySelector('.job-card-footer')?.textContent?.trim() || '';
      jobs.push({
          title: c.querySelector('.job-name')?.textContent?.trim(),
          salary: c.querySelector('.job-salary')?.textContent?.trim(),
          company: c.querySelector('.boss-name')?.textContent?.trim(),
          location: footerText.split(/\s+/).slice(1).join(' '),
          exp: c.querySelector('.tag-list li:first-child')?.textContent?.trim(),
          tags: Array.from(c.querySelectorAll('.tag-list li'))
                .slice(1).map(s => s.textContent.trim()).join(','),
          link: c.querySelector('a[href*="job_detail"]')?.href
      });
  });
  window.__jobs = jobs;

**选择器会过时**：招聘网站改版频繁。如果上面选择器取到的字段大量为空，用 `c.textContent` 全文提取后用正则/AI解析做兜底，而不是交出一堆空值。具体做法：把每张卡片的 `textContent` 整段交给 AI，按「岗位名称 | 薪资 | 公司 | 城市 | 经验」格式解析。

数据量大时（41K+ 字符），需要分批读取：slice(0,75)、slice(75,150)...

步骤 4：AI 智能筛选
提取后不要全部放入 Excel，要根据用户简历和目标方向做匹配筛选。

筛选逻辑是**动态生成**的，不是固定关键词。根据以下流程判断：

1. **从用户简历提取核心画像**：
   - 目标岗位类型（产品/开发/设计/运营/销售...）
   - 核心技能关键词（如 Python、Figma、投放、用户增长...）
   - 行业背景（教育/金融/电商/医疗...）
   - 语言优势（英语/日语/粤语...）
   - 经验年限

2. **生成保留规则**（标题或标签命中任一即保留）：
   - 与目标岗位类型直接相关的职位名称
   - 与核心技能关键词匹配的岗位
   - 符合行业背景的岗位
   - 符合语言优势的岗位（如英语好 → 保留外企/海外相关）

3. **生成排除规则**（标题明确属于其他职能的跳过）：
   - 与用户目标方向**完全不同职能**的岗位（如用户找产品，则排除纯开发/纯算法/纯运维；用户找开发，则排除纯销售/纯行政）
   - 纯实习岗（除非用户接受实习）
   - 用户明确排除的行业或公司类型

4. **灰色地带处理**（标题模糊、看不出是否匹配的）：
   - 优先保留，放入 🟠 可以尝试
   - 宁可多给用户看几个不太匹配的，也不要漏掉真正合适的
```

## 方式 B：Cookies 导入

引导用户导出 cookies：

> 需要你提供 Boss 直聘的登录 cookies，这样我才能帮你搜索。步骤：
>
> 1. 在 Chrome 里打开 Boss 直聘并确保已登录
> 2. 安装浏览器插件 **Cookie-Editor**（Chrome 商店可搜到）
> 3. 打开 Boss 直聘页面，点击 Cookie-Editor 图标
> 4. 点击「Export」→「Header String」，复制内容发给我
>
> ⚠️ 提醒：cookies 我只在本次搜索中临时使用，不会保存。但 Boss 直聘等平台风控较严，浏览器外的请求频率太高有小概率触发账号异常验证（需要重新登录或手机验证），建议控制请求频率、适度使用。

拿到 cookies 后，使用 Python 脚本发起请求：

```python
import requests

def search_zhipin(keywords, city, cookies_str):
    headers = {
        'User-Agent': 'Mozilla/5.0 ...',
        'Cookie': cookies_str
    }
    # 构造搜索 URL，发起请求，解析返回的 HTML/JSON
    # 提取岗位名称、公司、薪资、链接等信息
```

## 方式 C：用户手动搜索 + AI 辅助

如果用户不想提供 cookies 也没有 Chrome 插件：
1. 给用户推荐搜索关键词组合
2. 用户自己在 Boss 直聘搜索
3. 把感兴趣的 JD 截图或文字发给 AI
4. AI 进行匹配度分析 + 写打招呼消息
