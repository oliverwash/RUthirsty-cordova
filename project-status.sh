#!/bin/bash

# 喝水打卡应用 - 项目状态报告生成器

echo "📊 喝水打卡应用 - 项目状态报告"
echo "========================================"
echo ""
echo "生成时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 1. 项目基本信息
echo "📦 项目信息"
echo "----------------------------------------"
echo "项目名称: 喝水打卡 (RUthirsty)"
echo "版本: 1.0.0"
echo "包名: com.ruthirsty.app"
echo "平台: Android, Browser"
echo ""

# 2. 文件统计
echo "📁 文件统计"
echo "----------------------------------------"
echo "HTML 文件: $(find www -name "*.html" | wc -l) 个"
echo "CSS 文件: $(find www -name "*.css" | wc -l) 个"
echo "JS 文件: $(find www -name "*.js" | wc -l) 个"
echo "文档文件: $(find . -maxdepth 1 -name "*.md" | wc -l) 个"
echo "脚本文件: $(find . -maxdepth 1 -name "*.sh" | wc -l) 个"
echo ""

# 3. 代码行数统计
echo "📝 代码行数"
echo "----------------------------------------"
if [ -f www/index.html ]; then
    echo "index.html: $(wc -l < www/index.html) 行"
fi
if [ -f www/css/index.css ]; then
    echo "index.css: $(wc -l < www/css/index.css) 行"
fi
if [ -f www/js/index.js ]; then
    echo "index.js: $(wc -l < www/js/index.js) 行"
fi
if [ -f www/js/storage.js ]; then
    echo "storage.js: $(wc -l < www/js/storage.js) 行"
fi
echo "总计: $(find www -name "*.html" -o -name "*.css" -o -name "*.js" | xargs wc -l | tail -1 | awk '{print $1}') 行"
echo ""

# 4. Git 状态
echo "🔧 Git 状态"
echo "----------------------------------------"
echo "当前分支: $(git branch --show-current)"
echo "最新提交: $(git log -1 --oneline)"
echo "提交总数: $(git rev-list --count HEAD)"
echo "远程仓库: $(git remote get-url origin 2>/dev/null || echo '未配置')"
echo ""

# 5. Live Server 状态
echo "🌐 Live Server 状态"
echo "----------------------------------------"
if pgrep -f "live-server.*www" > /dev/null; then
    echo "状态: ✅ 运行中"
    echo "进程 PID: $(pgrep -f 'live-server.*www' | head -1)"
    echo "端口: 8000"
    echo "访问地址: http://localhost:8000/"

    # 测试连接
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/ | grep -q "200"; then
        echo "连接测试: ✅ 正常"
    else
        echo "连接测试: ❌ 失败"
    fi
else
    echo "状态: ❌ 未运行"
    echo "启动命令: ./start-server.sh"
fi
echo ""

# 6. 功能清单
echo "✅ 已实现功能"
echo "----------------------------------------"
echo "核心功能:"
echo "  ✅ 打卡按钮 - 记录喝水时间"
echo "  ✅ 今日统计 - 显示今天喝水次数"
echo "  ✅ 记录列表 - 显示所有打卡记录"
echo "  ✅ 数据持久化 - localStorage 存储"
echo "  ✅ 清空功能 - 删除所有记录"
echo ""
echo "界面功能:"
echo "  ✅ 响应式设计 - 适配各种屏幕"
echo "  ✅ 动画效果 - 打卡按钮动画"
echo "  ✅ 清新主题 - 蓝紫色渐变"
echo ""
echo "开发功能:"
echo "  ✅ 热重载 - live-server 自动刷新"
echo "  ✅ 后台运行 - nohup 后台运行"
echo "  ✅ 服务器管理 - 启动/停止/状态脚本"
echo "  ✅ 测试页面 - 功能测试页面"
echo ""

# 7. 可用命令
echo "🛠️ 可用命令"
echo "----------------------------------------"
echo "服务器管理:"
echo "  ./start-server.sh    - 启动 live-server"
echo "  ./stop-server.sh     - 停止 live-server"
echo "  ./status-server.sh   - 查看服务器状态"
echo ""
echo "开发工具:"
echo "  ./demo-hot-reload.sh - 热重载功能演示"
echo "  ./project-status.sh  - 生成项目状态报告"
echo ""
echo "Cordova:"
echo "  cordova run browser  - 浏览器运行"
echo "  cordova build android - 构建 Android APK"
echo ""

# 8. 文档列表
echo "📚 文档列表"
echo "----------------------------------------"
for doc in *.md; do
    if [ -f "$doc" ]; then
        lines=$(wc -l < "$doc")
        echo "  📄 $doc ($lines 行)"
    fi
done
echo ""

# 9. 磁盘使用
echo "💾 磁盘使用"
echo "----------------------------------------"
echo "项目总大小: $(du -sh . 2>/dev/null | cut -f1)"
echo "www 目录: $(du -sh www 2>/dev/null | cut -f1)"
echo "node_modules: $(du -sh node_modules 2>/dev/null | cut -f1)"
echo "platforms: $(du -sh platforms 2>/dev/null | cut -f1)"
echo ""

# 10. 下一步建议
echo "🚀 下一步建议"
echo "----------------------------------------"
echo "1. 访问 http://localhost:8000/ 测试应用"
echo "2. 运行 ./demo-hot-reload.sh 体验热重载"
echo "3. 阅读 QUICK-START.md 快速入门"
echo "4. 修改代码添加新功能"
echo "5. 构建 Android APK 部署到设备"
echo ""

echo "========================================"
echo "报告生成完成！"
echo ""
