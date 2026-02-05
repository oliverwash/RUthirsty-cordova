# 🚀 快速入门指南

## 5 分钟上手喝水打卡应用

### 第一步：启动服务器

```bash
./start-server.sh
```

你会看到：
```
✅ Live Server 启动成功！

📱 访问地址：
   - 本地: http://localhost:8000/
   - 测试页面: http://localhost:8000/test.html

🔥 热重载已启用，修改文件后浏览器会自动刷新
```

### 第二步：打开应用

在浏览器中访问：**http://localhost:8000/**

你会看到一个漂亮的喝水打卡界面！

### 第三步：使用应用

1. **点击中央大按钮** - 记录喝水时间
2. **查看顶部统计** - 显示今天喝了几次水
3. **查看底部列表** - 显示所有打卡记录
4. **点击清空按钮** - 删除所有记录

### 第四步：体验热重载

打开 `www/css/index.css`，找到这一行：

```css
header h1 {
    font-size: 28px;
    color: #667eea;  /* 改成 #ff6b6b 试试 */
    margin-bottom: 15px;
}
```

修改颜色后保存，浏览器会自动刷新，标题变成红色！

### 第五步：运行演示

想看完整的热重载演示？运行：

```bash
./demo-hot-reload.sh
```

这个脚本会自动修改文件并展示热重载效果。

---

## 📋 常用命令

```bash
# 启动服务器
./start-server.sh

# 查看状态
./status-server.sh

# 停止服务器
./stop-server.sh

# 查看日志
tail -f live-server.log

# 运行演示
./demo-hot-reload.sh
```

---

## 🎯 下一步

### 开发新功能

1. 修改 `www/index.html` - 改变页面结构
2. 修改 `www/css/index.css` - 改变样式
3. 修改 `www/js/index.js` - 改变逻辑

每次保存后，浏览器都会自动刷新！

### 构建 Android 应用

```bash
# 配置 Android SDK
export ANDROID_HOME=/path/to/android/sdk

# 构建 APK
cordova build android

# 安装到设备
cordova run android
```

---

## 📚 更多文档

- **README.md** - 完整项目说明
- **HOT-RELOAD-GUIDE.md** - 热重载详细指南
- **IMPLEMENTATION.md** - 技术实现细节
- **FINAL-SUMMARY.md** - 项目完整总结

---

## 💡 小贴士

1. **保持服务器运行** - 开发时不要停止 live-server
2. **使用开发者工具** - 按 F12 打开 Chrome DevTools
3. **查看控制台** - 可以看到 JavaScript 日志和错误
4. **小步提交** - 每完成一个功能就 git commit

---

## 🎉 开始使用吧！

现在你已经掌握了基础，可以开始开发了！

**祝你开发愉快！** 🚀
