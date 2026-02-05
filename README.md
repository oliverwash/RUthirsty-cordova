# 喝水打卡 Cordova 应用

一个简单的喝水打卡应用，帮助你养成健康的喝水习惯。

## 功能特性

- ✅ 一键打卡记录喝水时间
- 📊 实时显示今日喝水次数统计
- 📝 完整的打卡记录列表
- 💾 数据本地持久化存储
- 🎨 清新的蓝色主题界面
- 📱 响应式设计，适配各种屏幕

## 技术栈

- Apache Cordova
- 原生 HTML5/CSS3/JavaScript
- localStorage API
- Android 平台支持

## 快速开始

### 环境要求

- Node.js (已安装 v24.11.1)
- npm (已安装 v11.6.2)
- Cordova CLI (已安装)

### 安装依赖

```bash
npm install
```

### 浏览器测试

```bash
npm run serve
# 或
cordova run browser
```

### Android 构建

需要先配置 Android SDK 环境：

```bash
# 设置 ANDROID_HOME 环境变量
export ANDROID_HOME=/path/to/android/sdk

# 构建 APK
cordova build android

# 在设备上运行
cordova run android
```

## 项目结构

```
www/
├── index.html          # 主页面
├── css/
│   └── index.css      # 样式文件
└── js/
    ├── index.js       # 主逻辑
    └── storage.js     # 数据存储模块
```

## 使用说明

1. **打卡喝水**：点击中央的大圆形按钮记录当前喝水时间
2. **查看统计**：顶部显示今日已喝水次数
3. **查看记录**：底部列表显示所有打卡记录（最新的在上面）
4. **清空记录**：点击"清空"按钮可以删除所有记录

## 数据存储

应用使用 localStorage 进行数据持久化，数据格式如下：

```javascript
{
  records: [
    { id: 1738758625000, time: "2026-02-05 11:30:25" },
    ...
  ]
}
```

## 开发说明

- 应用在 Cordova `deviceready` 事件后初始化
- 支持浏览器模式测试（自动检测 Cordova 环境）
- 今日统计会在跨天后自动重置
- 所有数据存储在本地，不会上传到服务器

## 版本信息

- 版本：1.0.0
- 包名：com.ruthirsty.app
- 应用名：喝水打卡

## License

Apache-2.0
