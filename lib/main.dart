import 'package:flutter/material.dart';
import 'package:jusicool_ios/screens/splash_screen.dart';

//테스트용
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jusicool',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메인 화면')),
      body: const Center(
        child: Text('메인 화면입니다.', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
