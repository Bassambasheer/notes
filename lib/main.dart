import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notez/view/splash_screen.dart';
import 'theme/theme.dart';

const savekeyname = 'userloggedin';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
