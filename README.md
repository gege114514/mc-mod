# ServerIPDisplay - Minecraft Forge 1.20.1 Mod

在多人游戏界面顶部显示服务器IP地址横幅，点击即可复制到剪贴板。

## 功能

- 多人游戏界面顶部常驻金色横幅
- 点击横幅自动复制IP到剪贴板
- 彩色文本：金色前缀 + 青色IP + 绿色提示
- JSON配置文件，改IP不用改代码
- 深蓝半透明背景，不遮挡界面内容

## 快速开始

### GitHub Actions自动构建（推荐）

1. 把整个ServerIPDisplay_Clean文件夹上传到GitHub仓库
2. Push到main分支
3. 进入仓库Actions标签页，等构建完成
4. 下载Artifacts中的serveripdisplay-1.0.0.jar
5. 丢进mods/文件夹

### Windows本地构建

```
1. 安装JDK 17：https://adoptium.net/temurin/releases/?version=17
2. 双击build.bat
3. 等待BUILD SUCCESS
4. 在build\libs\找到serveripdisplay-1.0.0.jar
```

### Linux/Mac本地构建

```bash
chmod +x build.sh
./build.sh
# 输出在build/libs/serveripdisplay-1.0.0.jar
```

## 安装到Minecraft

1. 确保安装了Minecraft Forge 1.20.1 (47.x.x)
2. 把serveripdisplay-1.0.0.jar放进.minecraft/mods/文件夹
3. 启动游戏 -> 多人游戏 -> 看到顶部IP横幅

## 修改服务器IP

编辑游戏目录下的config/serveripdisplay.json：

```json
{
  "serverIP": "play.simpfun.cn:36988",
  "prefix": "[服务器IP]",
  "backgroundColor": -342117530,
  "borderColor": -33024,
  "prefixColor": -10496,
  "ipColor": -16711681,
  "suffixColor": -11141248,
  "suffix": "|  点击复制",
  "enableClickToCopy": true
}
```

| 参数 | 说明 | 默认值 |
|------|------|--------|
| serverIP | 服务器地址 | play.simpfun.cn:36988 |
| prefix | 前缀文字 | [服务器IP] |
| backgroundColor | 背景色（ARGB） | 深蓝半透明 |
| borderColor | 边框色 | 金色 |
| prefixColor | 前缀颜色 | 金色 |
| ipColor | IP文字颜色 | 青色 |
| suffixColor | 后缀颜色 | 绿色 |
| suffix | 后缀提示文字 | \| 点击复制 |
| enableClickToCopy | 是否启用点击复制 | true |

## 项目结构

```
ServerIPDisplay_Clean/
├── build.gradle
├── settings.gradle
├── build.sh
├── build.bat
├── gradlew
├── gradlew.bat
├── README.md
├── .github/workflows/build.yml
├── gradle/wrapper/gradle-wrapper.properties
└── src/main/
    ├── java/cn/simpfun/serveripdisplay/
    │   ├── ServerIPDisplay.java
    │   ├── config/IPDisplayConfig.java
    │   └── mixin/MultiplayerScreenMixin.java
    └── resources/
        ├── META-INF/mods.toml
        └── mixins.serveripdisplay.json
```

## 技术原理

Mixin注入点：

| 目标类 | 目标方法 | 注入位置 | 作用 |
|--------|----------|----------|------|
| JoinMultiplayerScreen | render() | HEAD | 在界面顶部绘制横幅 |
| JoinMultiplayerScreen | mouseClicked() | HEAD | 拦截点击 -> 复制IP |

## License

MIT
