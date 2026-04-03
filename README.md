# Flutter 本地通知（flutter_local_notifications）

## 简介

演示 **`flutter_local_notifications`**：在 Android 等平台上弹出一条系统通知（需通知权限）。README 与界面均说明：**远程推送（FCM 等）需另行接入 Firebase 或厂商通道**，与本插件解决的是不同层级的问题。

## 快速开始

### 环境要求

Flutter SDK。Android 13+ 常见需运行时通知权限；本 Demo 在展示前尝试申请。

### 运行

```bash
flutter pub get
flutter run
```

## 概念讲解

### 第一部分：`initialize` 与 `InitializationSettings`

当前依赖的 `flutter_local_notifications` 21.x 要求使用命名参数：`initialize(settings: InitializationSettings(...))`。Android 使用 `@mipmap/ic_launcher` 作为小图标资源。

### 第二部分：`show` 的参数

使用命名参数：`id`、`title`、`body`、`notificationDetails`。Web 上插件多为 no-op，Demo 以 `SnackBar` 提示改跑移动端或桌面。

## 完整示例

见 `lib/main.dart`：`_initNotifications`、按钮 `onPressed` 里 `show`。

## 注意事项

- iOS/macOS 若要真正弹出，还需在宿主工程配置通知能力、权限文案等（随 Xcode 能力勾选变化）。
- 上架应用的通知类别、渠道合规请按商店指南处理。

## 完整讲解（中文）

「推送」一词常被混用：**本地通知**是 App 自己定时或即时触发；**远程推送**是服务器经 APNs/FCM 把消息投下来。本 Demo 只覆盖前者，避免把 Firebase 配置、证书、Topics 一次性全压进来。先把本地通知渠道、权限、图标这三件事跑通，再接 FCM，会顺很多。
