#!/bin/bash

# 扫描当前目录（根目录）的所有图片
IMAGE_DIR="."
OUTPUT_FILE="index.html"
REPO_NAME="${GITHUB_REPOSITORY:-LM-shenghao/loli}"

echo "Generating $OUTPUT_FILE ..."

cat > $OUTPUT_FILE << EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>星星的萝莉图库</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f8f9fa; margin: 0; padding: 20px; }
        h1 { text-align: center; color: #343a40; }
        .gallery { display: flex; flex-wrap: wrap; justify-content: center; gap: 12px; max-width: 1400px; margin: 0 auto; }
        .gallery img { width: 200px; height: 200px; object-fit: cover; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: 0.25s; background: #fff; padding: 4px; }
        .gallery img:hover { transform: scale(1.08); box-shadow: 0 8px 20px rgba(0,0,0,0.2); }
        .footer { text-align: center; margin-top: 30px; color: #6c757d; }
    </style>
</head>
<body>
    <h1>✨ 星星的萝莉图库</h1>
    <div class="gallery">
EOF

# 查找当前目录下所有图片（排除脚本自身和已生成的 index.html）
find "$IMAGE_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) ! -name "generate_index.sh" ! -name "index.html" | sort | while read -r file; do
    file="${file#./}"
    img_url="https://raw.githubusercontent.com/${REPO_NAME}/main/${file}"
    echo "        <img src=\"$img_url\" alt=\"image\" loading=\"lazy\">" >> $OUTPUT_FILE
done

cat >> $OUTPUT_FILE << EOF
    </div>
    <div class="footer">
        🖼️ 共 $(find "$IMAGE_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) ! -name "generate_index.sh" ! -name "index.html" | wc -l) 张图片
    </div>
</body>
</html>
EOF

echo "$OUTPUT_FILE 生成成功！"
