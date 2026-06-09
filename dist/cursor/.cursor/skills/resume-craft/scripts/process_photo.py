#!/usr/bin/env python3
"""
照片处理脚本：裁剪为 3:4 比例 → 压缩 → 转 base64

用法：
    python scripts/process_photo.py <图片路径> [最大宽度]

示例：
    python scripts/process_photo.py photo.jpg
    python scripts/process_photo.py photo.png 150

输出：
    将 base64 字符串打印到标准输出，可直接嵌入 HTML 的 <img src="data:image/jpeg;base64,...">

依赖：
    pip install Pillow
"""

import sys
import io
import base64
from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("错误：需要安装 Pillow")
    print("运行以下命令安装：")
    print("  pip install Pillow")
    sys.exit(1)


def process_photo(image_path, ratio=(3, 4), max_width=120, quality=85):
    img = Image.open(image_path)

    if img.mode in ('RGBA', 'P'):
        img = img.convert('RGB')

    w, h = img.size
    target_ratio = ratio[0] / ratio[1]
    current_ratio = w / h

    if current_ratio > target_ratio:
        new_w = int(h * target_ratio)
        left = (w - new_w) // 2
        img = img.crop((left, 0, left + new_w, h))
    elif current_ratio < target_ratio:
        new_h = int(w / target_ratio)
        top = (h - new_h) // 2
        img = img.crop((0, top, w, top + new_h))

    if img.width > max_width:
        scale = max_width / img.width
        new_size = (max_width, int(img.height * scale))
        img = img.resize(new_size, Image.LANCZOS)

    buffer = io.BytesIO()
    img.save(buffer, format='JPEG', quality=quality, optimize=True)
    b64 = base64.b64encode(buffer.getvalue()).decode('utf-8')

    return b64


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法：python scripts/process_photo.py <图片路径> [最大宽度]")
        sys.exit(1)

    image_path = sys.argv[1]
    max_width = int(sys.argv[2]) if len(sys.argv) > 2 else 120

    if not Path(image_path).exists():
        print(f"错误：找不到文件 {image_path}")
        sys.exit(1)

    result = process_photo(image_path, max_width=max_width)
    print(result)
