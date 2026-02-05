# Android APK 构建指南

## 当前状态

❌ Android SDK 未配置
- ANDROID_HOME 环境变量未设置
- Android SDK 工具未安装

## 构建 Android APK 的方法

### 方法 1：在本地配置 Android SDK（推荐用于开发）

#### 步骤 1：安装 Android SDK

```bash
# 下载 Android Command Line Tools
# 访问: https://developer.android.com/studio#command-tools

# 或使用 sdkmanager 安装
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip
unzip commandlinetools-linux-9477386_latest.zip -d ~/android-sdk
```

#### 步骤 2：配置环境变量

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
export ANDROID_HOME=$HOME/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools/33.0.0

# 重新加载配置
source ~/.bashrc
```

#### 步骤 3：安装必要的 SDK 组件

```bash
# 接受许可
yes | sdkmanager --licenses

# 安装必要组件
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
```

#### 步骤 4：构建 APK

```bash
# 构建调试版 APK
cordova build android

# 构建发布版 APK
cordova build android --release

# APK 位置
# 调试版: platforms/android/app/build/outputs/apk/debug/app-debug.apk
# 发布版: platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk
```

#### 步骤 5：安装到设备

```bash
# 连接 Android 设备并启用 USB 调试

# 检查设备连接
adb devices

# 安装 APK
cordova run android
# 或
adb install platforms/android/app/build/outputs/apk/debug/app-debug.apk
```

---

### 方法 2：使用 GitHub Actions 自动构建（推荐用于 CI/CD）

创建 `.github/workflows/android-build.yml`:

```yaml
name: Build Android APK

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'

    - name: Setup Java
      uses: actions/setup-java@v3
      with:
        distribution: 'temurin'
        java-version: '11'

    - name: Setup Android SDK
      uses: android-actions/setup-android@v2

    - name: Install dependencies
      run: npm install

    - name: Install Cordova
      run: npm install -g cordova

    - name: Build Android APK
      run: cordova build android --release

    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: app-release
        path: platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk
```

---

### 方法 3：使用在线构建服务

#### PhoneGap Build（已停止服务）
- 已于 2020 年停止服务

#### Ionic Appflow
```bash
# 安装 Ionic CLI
npm install -g @ionic/cli

# 登录 Ionic
ionic login

# 构建应用
ionic build
```

#### Apache Cordova Cloud Build
- 社区维护的构建服务
- 访问: https://build.phonegap.com/

---

### 方法 4：使用 Docker 构建（推荐用于无 Android SDK 环境）

创建 `Dockerfile`:

```dockerfile
FROM beevelop/cordova:latest

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

RUN cordova platform add android
RUN cordova build android --release

CMD ["sh"]
```

构建命令:

```bash
# 构建 Docker 镜像
docker build -t ruthirsty-cordova .

# 运行容器并构建 APK
docker run -v $(pwd)/platforms:/app/platforms ruthirsty-cordova cordova build android

# APK 将在 platforms/android/app/build/outputs/apk/ 目录
```

---

## 当前项目的快速构建方案

### 使用浏览器版本（已可用）

```bash
# 当前已经在运行
http://localhost:8000/

# 这是最快的测试方式
# 所有功能都可以在浏览器中测试
```

### 生成 PWA（渐进式 Web 应用）

可以将应用转换为 PWA，无需 Android SDK：

1. 添加 manifest.json
2. 添加 Service Worker
3. 用户可以"添加到主屏幕"

---

## 签名 APK（用于发布）

### 生成密钥库

```bash
keytool -genkey -v -keystore ruthirsty.keystore -alias ruthirsty -keyalg RSA -keysize 2048 -validity 10000
```

### 签名 APK

```bash
# 使用 jarsigner
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ruthirsty.keystore app-release-unsigned.apk ruthirsty

# 使用 zipalign 优化
zipalign -v 4 app-release-unsigned.apk ruthirsty-release.apk
```

---

## 故障排查

### 问题 1：ANDROID_HOME 未设置

```bash
# 检查环境变量
echo $ANDROID_HOME

# 如果为空，设置它
export ANDROID_HOME=/path/to/android/sdk
```

### 问题 2：Gradle 构建失败

```bash
# 清理构建
cd platforms/android
./gradlew clean

# 重新构建
cd ../..
cordova build android
```

### 问题 3：设备未识别

```bash
# 检查 adb
adb devices

# 重启 adb
adb kill-server
adb start-server

# 检查 USB 调试是否启用
```

### 问题 4：构建超时

```bash
# 增加 Gradle 内存
export GRADLE_OPTS="-Xmx4096m -XX:MaxPermSize=512m"
```

---

## 推荐方案

### 对于当前环境（Codespace）

**最佳方案：使用浏览器版本**
- ✅ 已经运行: http://localhost:8000/
- ✅ 所有功能可用
- ✅ 热重载开发
- ✅ 无需 Android SDK

**备选方案：使用 GitHub Actions**
- ✅ 自动构建
- ✅ 无需本地 Android SDK
- ✅ 可下载 APK

**未来方案：配置 Android SDK**
- 需要下载和配置 Android SDK
- 需要较大的磁盘空间（~5GB）
- 适合长期开发

---

## 快速测试应用

### 在浏览器中测试（推荐）

```bash
# 已经在运行
http://localhost:8000/

# 打开浏览器开发者工具
# 切换到移动设备模式（F12 → Toggle device toolbar）
# 选择 Android 设备进行测试
```

### 使用 Chrome 远程调试

1. 在 Android 设备上安装 Chrome
2. 启用 USB 调试
3. 连接设备到电脑
4. 在 Chrome 中访问 `chrome://inspect`
5. 打开 http://localhost:8000/

---

## 总结

### 当前可用的方式

1. ✅ **浏览器测试** - 立即可用
   - 访问: http://localhost:8000/
   - 功能完整
   - 热重载支持

2. ⏳ **GitHub Actions** - 需要配置
   - 自动构建 APK
   - 无需本地 SDK

3. ⏳ **Docker 构建** - 需要 Docker
   - 隔离环境
   - 可重复构建

4. ❌ **本地构建** - 需要 Android SDK
   - 需要配置环境
   - 需要磁盘空间

### 建议

**现阶段：**
- 使用浏览器版本进行开发和测试
- 所有功能都可以在浏览器中验证

**下一步：**
- 配置 GitHub Actions 自动构建
- 或在有 Android SDK 的机器上构建

**最终：**
- 签名 APK
- 发布到 Google Play Store

---

需要我帮你配置 GitHub Actions 自动构建吗？
