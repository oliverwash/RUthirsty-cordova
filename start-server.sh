#!/bin/bash

# 喝水打卡应用 - Live Server 启动脚本
# 使用 live-server 提供热重载功能

echo "🚀 启动喝水打卡应用 Live Server..."

# 检查是否已有进程在运行
if pgrep -f "live-server.*www" > /dev/null; then
    echo "⚠️  Live Server 已在运行"
    echo "进程信息："
    ps aux | grep "live-server.*www" | grep -v grep
    echo ""
    echo "如需重启，请先运行: ./stop-server.sh"
    exit 1
fi

# 启动 live-server
echo "📦 启动 live-server (端口 8000)..."
nohup npx live-server www --port=8000 --host=0.0.0.0 --no-browser > live-server.log 2>&1 &

# 等待启动
sleep 3

# 检查是否启动成功
if pgrep -f "live-server.*www" > /dev/null; then
    echo "✅ Live Server 启动成功！"
    echo ""
    echo "📱 访问地址："
    echo "   - 本地: http://localhost:8000/"
    echo "   - 测试页面: http://localhost:8000/test.html"
    echo ""
    echo "🔥 热重载已启用，修改文件后浏览器会自动刷新"
    echo ""
    echo "📋 查看日志: tail -f live-server.log"
    echo "🛑 停止服务: ./stop-server.sh"
    echo ""
    echo "进程 PID: $(pgrep -f 'live-server.*www')"
else
    echo "❌ 启动失败，请查看日志: cat live-server.log"
    exit 1
fi
