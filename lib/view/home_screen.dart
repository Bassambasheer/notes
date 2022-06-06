import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notez/view/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/api/firebase_api.dart';
import '../core/constantwidgets/textwidget.dart';
import '../core/models/note_model.dart';
import '../theme/theme.dart';
import 'add_notes screen.dart';
import 'widgets/grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: white,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  type: PageTransitionType.bottomToTopJoined,
                  child: const AddNotes(),
                  childCurrent: this),
            );
          },
          child: const Icon(
            Icons.add,
            color: Color.fromARGB(255, 255, 163, 4),
            size: 50,
          ),
        ),
        bottomNavigationBar: Container(
            width: double.infinity,
            height: 60,
            color: Colors.grey[100],
            child: BottomAppBar(
              color: const Color(0xFFFFFFFF),
              shape: const AutomaticNotchedShape(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(0),
                  ),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
              ),
              notchMargin: 4.5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      user = null;
                      final _sharedprefs =
                          await SharedPreferences.getInstance();
                      _sharedprefs.clear();
                      await googleSignIn.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (ctx) => LoginInScreen()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                    splashRadius: 25,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                    iconSize: 35,
                  ),
                ],
              ),
            )),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoUrl!),
                  radius: 25,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextWidget(
                    txt: "Notes",
                    size: 35,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<List<Note>>(
                  stream: FirebaseApi.getNote(),
                  builder: (context, AsyncSnapshot<List<Note>> snapshot) {
                    return GridViewWidget(
                      data: snapshot.data,
                    );
                  })
            ],
          ),
        )));
  }
}
