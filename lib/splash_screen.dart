import 'dart:async';

import 'package:flutter/material.dart';

import 'models/functions.dart';
import 'screens/home_page_screen.dart';
import 'screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  _checkLoginStatus() async {
    var authtoken = await SecuredStorage(myKey: 'token').getData();
    Timer(const Duration(milliseconds: 500), () {
      if (authtoken == null) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const LoginPage()));
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const HomeMenu()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
