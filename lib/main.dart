// 本地通知 flutter_local_notifications（远程推送 FCM 需单独接 Firebase）
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _notifications =
    FlutterLocalNotificationsPlugin();

Future<void> _initNotifications() async {
  if (kIsWeb) return;
  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  const darwin = DarwinInitializationSettings();
  await _notifications.initialize(
    settings: const InitializationSettings(
      android: android,
      iOS: darwin,
      macOS: darwin,
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PushDemoPage());
  }
}

class PushDemoPage extends StatelessWidget {
  const PushDemoPage({super.key});

  Future<void> _showLocal(BuildContext context) async {
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Web 上请用 Android / iOS / Desktop 构建体验系统通知')),
      );
      return;
    }
    const androidDetails = AndroidNotificationDetails(
      'demo_channel',
      'Demo',
      channelDescription: 'Demo notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    if (Platform.isAndroid) {
      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
    }
    await _notifications.show(
      id: 0,
      title: 'Demo',
      body: 'Hello from flutter_local_notifications',
      notificationDetails: details,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local notifications')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '本页演示应用内调起的本地通知。远程推送（FCM 等）需要在各端配置密钥与服务。',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => _showLocal(context),
                child: const Text('显示一条本地通知'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
