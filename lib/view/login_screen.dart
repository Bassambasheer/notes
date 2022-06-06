import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notez/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

GoogleSignInAccount? user;

class LoginInScreen extends StatelessWidget {
  LoginInScreen({Key? key}) : super(key: key);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 232, 239),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.5,
                        image: NetworkImage(
                            "https://banner2.cleanpng.com/20180324/bwq/kisspng-google-logo-google-adwords-google-panda-chrome-5ab6e660439c29.6670544415219359682769.jpg"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () async {
                    await signinwithgoogle();
                    final _sharedprefs = await SharedPreferences.getInstance();
                    _sharedprefs.setBool(savekeyname, true);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => HomeScreen()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                              const BorderSide(color: Colors.grey, width: 0.9)),
                      child: const ListTile(
                        title: Text(
                          "Signin with google",
                          style: TextStyle(fontSize: 20),
                        ),
                        trailing: Icon(Icons.navigate_next_outlined),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signinwithgoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    user = googleUser;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
