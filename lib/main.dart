import 'dart:io';
import 'splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBHg6yogOVUCKezTj77vfI0ncqfjq6FllQ",
      appId: "1:469913584340:android:1b82941993445c654ab141",
      messagingSenderId: "469913584340",
      projectId: "school-erp-notofications",
    ));
  } else {
    await Firebase.initializeApp();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBHg6yogOVUCKezTj77vfI0ncqfjq6FllQ",
      appId: "1:469913584340:android:1b82941993445c654ab141",
      messagingSenderId: "469913584340",
      projectId: "school-erp-notofications",
    ));
  } else {
    await Firebase.initializeApp();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navjyoti Model School',
      theme: ThemeData(
        // useMaterial3: true,
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF128C7E)),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF075E54),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
