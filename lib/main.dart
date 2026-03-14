// Flutter 推送通知
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Push Notification')),
        body: Center(
          child: Text('Use firebase_messaging package'),
        ),
      ),
    );
  }
}
