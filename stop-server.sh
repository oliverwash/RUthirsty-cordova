#!/bin/bash

# 喝水打卡应用 - 停止 Live Server 脚本

echo "🛑 停止 Live Server..."

# 查找并停止 live-server 进程
PIDS=$(pgrep -f "live-server.*www")

if [ -z "$PIDS" ]; then
    echo "ℹ️  没有找到运行中的 Live Server 进程"
    exit 0
fi

echo "找到进程: $PIDS"

# 停止进程
for PID in $PIDS; do
    echo "停止进程 $PID..."
    kill $PID 2>/dev/null
done

# 等待进程结束
sleep 2

# 检查是否还在运行
if pgrep -f "live-server.*www" > /dev/null; then
    echo "⚠️  进程未完全停止，使用强制停止..."
    pkill -9 -f "live-server.*www"
    sleep 1
fi

# 验证
if pgrep -f "live-server.*www" > /dev/null; then
    echo "❌ 停止失败"
    exit 1
else
    echo "✅ Live Server 已停止"
fi
