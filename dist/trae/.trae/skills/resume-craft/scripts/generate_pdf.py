#!/usr/bin/env python3
"""
HTML → PDF 转换脚本（使用 Playwright）

用法：
    python scripts/generate_pdf.py <html文件路径> [pdf输出路径]

示例：
    python scripts/generate_pdf.py 周静儿-AI产品经理简历.html
    python scripts/generate_pdf.py resume.html output/resume.pdf

依赖：
    pip install playwright
    playwright install chromium
"""

import sys
from pathlib import Path

try:
    from playwright.sync_api import sync_playwright
except ImportError:
    print("错误：需要安装 Playwright")
    print("运行以下命令安装：")
    print("  pip install playwright")
    print("  playwright install chromium")
    sys.exit(1)


def html_to_pdf(html_path, pdf_path=None):
    html_path = Path(html_path).resolve()

    if not html_path.exists():
        print(f"错误：找不到文件 {html_path}")
        return None

    if pdf_path is None:
        pdf_path = html_path.with_suffix('.pdf')
    else:
        pdf_path = Path(pdf_path).resolve()

    pdf_path.parent.mkdir(parents=True, exist_ok=True)

    html_content = html_path.read_text(encoding='utf-8')

    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()

        page.set_content(html_content, wait_until="networkidle")
        page.wait_for_timeout(2000)

        page.evaluate("document.body.classList.add('pdf-mode')")

        page.pdf(
            path=str(pdf_path),
            format="A4",
            margin={"top": "0mm", "right": "0mm", "bottom": "0mm", "left": "0mm"},
            print_background=True,
        )

        browser.close()

    print(f"PDF 已生成：{pdf_path}")
    return pdf_path


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法：python scripts/generate_pdf.py <html文件路径> [pdf输出路径]")
        sys.exit(1)

    html_file = sys.argv[1]
    pdf_file = sys.argv[2] if len(sys.argv) > 2 else None

    html_to_pdf(html_file, pdf_file)
