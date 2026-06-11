# 海外地区 — 招聘平台清单与搜索语法

> 用户在海外找工作时，推荐平台和执行搜索前必须读取本文件中**用户选择的地区**部分，无需通读全文。

## 平台清单（分地区，推荐给用户多选）

**澳大利亚：**
- Seek Australia（seek.com.au）— 澳洲最大求职平台
- Jora（jora.com）
- Indeed Australia（au.indeed.com）
- Facebook Jobs / Groups — 澳洲很活跃

**新西兰：**
- Seek New Zealand（seek.co.nz）— 独立站点，与澳洲 Seek 分开
- Trade Me Jobs（trademe.co.nz）— 新西兰本土最大
- Indeed New Zealand

**美国 / 加拿大：**
- ZipRecruiter（ziprecruiter.com）
- Monster（monster.com）
- Dice（dice.com）— 科技岗专用
- USAJobs（usajobs.gov）— 美国政府岗位
- AngelList / Wellfound — 创业公司

**英国：**
- Reed（reed.co.uk）
- Totaljobs（totaljobs.com）
- CV-Library（cv-library.co.uk）
- Indeed UK（uk.indeed.com）

**欧洲（德语区）：**
- StepStone（stepstone.de）
- XING（xing.com）— 德语区 LinkedIn

**日本：**
- Daijob（daijob.com）— 面向外国人
- GaijinPot Jobs（jobs.gaijinpot.com）— 面向外国人
- Rikunabi（rikunabi.com）

**韩国：**
- Saramin（saramin.co.kr）— 韩国最大求职平台
- JobKorea（jobkorea.co.kr）— 韩国第二大
- WorkNet（work.go.kr）— 韩国政府官方平台
- People'n Job（peoplenjob.com）— 面向外国人

**新加坡：**
- MyCareersFuture（mycareersfuture.gov.sg）— 政府官方平台
- JobStreet Singapore（jobstreet.com.sg）

**东南亚（马来西亚/菲律宾/印尼等）：**
- JobStreet（jobstreet.com）— 覆盖多个东南亚国家
- JobsDB（jobsdb.com）— 港澳及东南亚

**对话示例：**
> AI：「你在澳大利亚找工作，以下平台比较常用，想搜哪些？（可多选，或说"全搜"）」
> 1. Seek Australia（澳洲最大）
> 2. LinkedIn
> 3. Indeed Australia
> 4. Jora
> 5. Glassdoor
> 6. Facebook Jobs/Groups
>
> 用户：「1、2、3」

## 免登录搜索指令（WebSearch，分地区）

**澳大利亚 / 新西兰：**
- `site:seek.com.au 岗位名 城市`（Seek 澳洲）
- `site:seek.co.nz 岗位名 城市`（Seek 新西兰，独立站点）
- `site:trademe.co.nz/a/jobs 岗位名 城市`（Trade Me Jobs，新西兰本土）
- `site:jora.com 岗位名 城市`（Jora）
- `site:au.indeed.com 岗位名 城市`（Indeed 澳洲）
- 如需工签筛选：追加 `"visa sponsorship" OR "sponsor"`

**美国 / 加拿大：**
- `site:ziprecruiter.com 岗位名 城市`（ZipRecruiter）
- `site:monster.com 岗位名 城市`（Monster）
- `site:dice.com 岗位名`（Dice，科技岗专用）
- `site:usajobs.gov 岗位名`（USAJobs，美国政府岗位）
- `site:wellfound.com 岗位名`（AngelList/Wellfound，创业公司）
- 如需工签筛选：追加 `"h1b" OR "visa sponsorship" OR "work authorization"`

**英国：**
- `site:reed.co.uk 岗位名 城市`（Reed）
- `site:totaljobs.com 岗位名 城市`（Totaljobs）
- `site:cv-library.co.uk 岗位名 城市`（CV-Library）
- 如需工签筛选：追加 `"visa sponsorship" OR "skilled worker visa" OR "sponsorship licence"`

**欧洲（德语区）：**
- `site:stepstone.de 岗位名 城市`（StepStone）
- `site:xing.com 岗位名 城市`（XING）

**日本：**
- `site:daijob.com 岗位名`（Daijob，面向外国人）
- `site:jobs.gaijinpot.com 岗位名`（GaijinPot Jobs，面向外国人）
- `site:rikunabi.com 岗位名`（Rikunabi）
- 如需工签筛选：追加 `"visa support" OR "ビザサポート"`

**韩国：**
- `site:saramin.co.kr 岗位名`（Saramin，韩国最大）
- `site:jobkorea.co.kr 岗位名`（JobKorea）
- `site:work.go.kr 岗位名`（WorkNet，政府官方）
- `site:peoplenjob.com 岗位名`（People'n Job，面向外国人）
- 如需工签筛选：追加 `"visa" OR "비자 지원" OR "외국인 가능"`

**新加坡：**
- `site:mycareersfuture.gov.sg 岗位名`（MyCareersFuture，政府官方）
- `site:jobstreet.com.sg 岗位名`（JobStreet 新加坡）

**东南亚（马来/菲律宾/印尼等）：**
- `site:jobstreet.com 岗位名 国家`（JobStreet）
- `site:jobsdb.com 岗位名 城市`（JobsDB，港澳及东南亚）

**社交平台招聘（海外地区可选）：**
- `site:facebook.com/jobs 岗位名 城市`（Facebook Jobs）
- `site:reddit.com 岗位名 hiring 城市`（Reddit 招聘帖）

## 岗位下架标志语（质检时效验证用）

访问岗位链接后，页面出现以下文案说明岗位已下架/过期，应直接移除：

- LinkedIn：「No longer accepting applications」
- Indeed：「This job has expired」「This job is no longer available」
- Seek（澳/新）：「This job is no longer advertised」
- Glassdoor：「This job is no longer available」
- ZipRecruiter / Monster 等：「This job is unavailable」「Job closed」
- 通用信号：页面 404、自动跳转回搜索页、岗位详情内容为空

注意：以上文案可能随平台改版变化，判断标准是「页面是否还在正常展示该岗位的完整 JD 和投递入口」，而不是死磕字面匹配。
