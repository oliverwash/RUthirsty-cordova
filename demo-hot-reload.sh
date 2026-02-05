#!/bin/bash

# 喝水打卡应用 - 热重载功能演示脚本
# 这个脚本会自动修改文件并展示热重载效果

echo "🎬 喝水打卡应用 - 热重载功能演示"
echo "================================"
echo ""

# 检查服务器是否运行
if ! pgrep -f "live-server.*www" > /dev/null; then
    echo "⚠️  Live Server 未运行，正在启动..."
    ./start-server.sh
    sleep 3
fi

echo "✅ Live Server 正在运行"
echo ""
echo "📱 请在浏览器中打开: http://localhost:8000/"
echo ""
echo "按 Enter 键开始演示..."
read

# 演示 1: 修改标题颜色
echo ""
echo "🎨 演示 1: 修改标题颜色"
echo "------------------------"
echo "将标题颜色从蓝色改为红色..."
sleep 2

# 备份原文件
cp www/css/index.css www/css/index.css.backup

# 修改颜色
sed -i 's/color: #667eea;/color: #ff6b6b;/' www/css/index.css

echo "✅ 已修改 www/css/index.css"
echo "💡 查看浏览器，标题应该变成红色了！"
echo ""
echo "按 Enter 键继续下一个演示..."
read

# 演示 2: 修改按钮文字
echo ""
echo "📝 演示 2: 修改按钮文字"
echo "------------------------"
echo "将按钮文字从'打卡喝水'改为'喝水啦'..."
sleep 2

# 备份原文件
cp www/index.html www/index.html.backup

# 修改文字
sed -i 's/打卡喝水/喝水啦/' www/index.html

echo "✅ 已修改 www/index.html"
echo "💡 查看浏览器，按钮文字应该变了！"
echo ""
echo "按 Enter 键继续下一个演示..."
read

# 演示 3: 添加控制台日志
echo ""
echo "🔍 演示 3: 添加控制台日志"
echo "------------------------"
echo "在打卡功能中添加控制台日志..."
sleep 2

# 备份原文件
cp www/js/index.js www/js/index.js.backup

# 在 handleCheckin 函数开头添加日志
sed -i '/handleCheckin: function() {/a\        console.log("🎉 用户点击了打卡按钮！");' www/js/index.js

echo "✅ 已修改 www/js/index.js"
echo "💡 打开浏览器控制台（F12），点击打卡按钮，应该能看到日志！"
echo ""
echo "按 Enter 键恢复原始文件..."
read

# 恢复原始文件
echo ""
echo "🔄 恢复原始文件..."
echo "------------------------"

if [ -f www/css/index.css.backup ]; then
    mv www/css/index.css.backup www/css/index.css
    echo "✅ 已恢复 www/css/index.css"
fi

if [ -f www/index.html.backup ]; then
    mv www/index.html.backup www/index.html
    echo "✅ 已恢复 www/index.html"
fi

if [ -f www/js/index.js.backup ]; then
    mv www/js/index.js.backup www/js/index.js
    echo "✅ 已恢复 www/js/index.js"
fi

sleep 2

echo ""
echo "🎉 演示完成！"
echo "================================"
echo ""
echo "📋 演示总结："
echo "   1. ✅ 修改 CSS 文件 → 浏览器自动刷新，样式立即生效"
echo "   2. ✅ 修改 HTML 文件 → 浏览器自动刷新，内容立即更新"
echo "   3. ✅ 修改 JS 文件 → 浏览器自动刷新，逻辑立即生效"
echo ""
echo "💡 这就是热重载的威力！"
echo "   - 无需手动刷新浏览器"
echo "   - 修改即时生效"
echo "   - 大大提高开发效率"
echo ""
echo "🚀 现在你可以自己尝试修改文件，体验热重载功能！"
echo ""
