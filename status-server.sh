#!/bin/bash

# 喝水打卡应用 - 服务器状态检查脚本

echo "📊 Live Server 状态检查"
echo "================================"
echo ""

# 检查进程
if pgrep -f "live-server.*www" > /dev/null; then
    echo "✅ 状态: 运行中"
    echo ""
    echo "📋 进程信息:"
    ps aux | grep "live-server.*www" | grep -v grep | awk '{printf "   PID: %s\n   CPU: %s%%\n   MEM: %s%%\n   命令: %s\n", $2, $3, $4, substr($0, index($0,$11))}'
    echo ""

    # 检查端口
    echo "🌐 端口监听:"
    PORT_INFO=$(ss -tlnp 2>/dev/null | grep :8000 || netstat -tlnp 2>/dev/null | grep :8000)
    if [ -n "$PORT_INFO" ]; then
        echo "   ✅ 端口 8000 正在监听"
        echo "   $PORT_INFO"
    else
        echo "   ⚠️  端口 8000 未监听"
    fi
    echo ""

    # 测试访问
    echo "🔍 连接测试:"
    if curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/ | grep -q "200"; then
        echo "   ✅ HTTP 200 - 服务正常"
    else
        echo "   ❌ 无法访问服务"
    fi
    echo ""

    echo "📱 访问地址:"
    echo "   - 主应用: http://localhost:8000/"
    echo "   - 测试页面: http://localhost:8000/test.html"
    echo ""

    echo "📋 日志文件:"
    echo "   - 位置: live-server.log"
    echo "   - 查看: tail -f live-server.log"
    echo "   - 最后 5 行:"
    tail -5 live-server.log 2>/dev/null | sed 's/^/     /'

else
    echo "❌ 状态: 未运行"
    echo ""
    echo "💡 启动服务: ./start-server.sh"
fi

echo ""
echo "================================"
