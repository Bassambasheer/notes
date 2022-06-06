import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constantwidgets/textwidget.dart';
import '../main.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => LoginInScreen()));
  }

  Future checkUserLoggedIn() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    final _userloggedin =  _sharedprefs.getBool(savekeyname);
    if (_userloggedin == null || _userloggedin == false) {
      goToLogin();
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      user = await googleSignIn.signIn();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    }
  }
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: TextWidget(txt: "Keep your Note")),
    );
  }
}
