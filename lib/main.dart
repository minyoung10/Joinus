import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/screen/account/login.dart';

import 'screen/bottom/bottom.dart';
import 'firebase_options.dart';
import 'screen/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Fistpage());
}

class Fistpage extends StatelessWidget {
  const Fistpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(239, 89, 125, 1),
      ),
      initialRoute: '/splash',
      routes: {
        '/': (BuildContext context) => BottomNavigation(),
        '/login': (BuildContext context) => LoginPage(),
        '/splash': (BuildContext context) => const VideoPlayerScreen(),
      },
    );
  }
}
