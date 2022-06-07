import 'package:flutter/material.dart';
import 'package:notez/view/widgets/colors.dart';
import 'package:notez/view/widgets/colorscard.dart';

import '../core/api/firebase_api.dart';
import '../core/models/note_model.dart';
import '../theme/theme.dart';
import 'home_screen.dart';

class AddNotes extends StatefulWidget {
  const AddNotes(
      {this.id,
      this.title,
      this.description,
      this.time,
      this.isedit = false,
      this.color = 0XFFFFFFFF,
      Key? key})
      : super(key: key);
  final String? title;
  final String? description;
  final String? id;
  final DateTime? time;
  final bool isedit;
  final int color;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();
  @override
  void dispose() {
    widget.isedit == true ? editNote() : addnote();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title != null) {
      titlecontroller.text = widget.title.toString();
    }
    if (widget.description != null) {
      descriptioncontroller.text = widget.description.toString();
    }
    return Scaffold(
        backgroundColor: colorList[currentIndex].color,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 10,
          onPressed: () {},
          child: const Icon(
            Icons.done,
            color: Colors.amber,
            size: 30,
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                colorList.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                    });
                    scaffoldColor = colorList[currentIndex].color.value;
                  },
                  child: ColorChoiceCard(
                    isSelected: index == currentIndex ? true : false,
                    color: colorList[index].color,
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          shadowColor: white,
          backgroundColor: white,
          iconTheme: const IconThemeData(
            color: black,
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.push_pin_outlined)),
            widget.id != null
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      FirebaseApi.deleteNote(widget.id!);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeScreen())),
                          (route) => false);
                    },
                  )
                : const SizedBox(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextField(
                  controller: titlecontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 30),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400))),
              TextField(
                controller: descriptioncontroller,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ));
  }

  addnote() async {
    Note note = Note(
        color: scaffoldColor,
        title: titlecontroller.text.trim(),
        description: descriptioncontroller.text.trim(),
        createdTime: DateTime.now());
    if (titlecontroller.text.trim().isEmpty &&
        descriptioncontroller.text.trim().isEmpty) {
      return;
    } else {
      await FirebaseApi.createNote(note);
    }
  }

  editNote() async {
    Note note = Note(
        color: scaffoldColor,
        title: titlecontroller.text.trim(),
        description: descriptioncontroller.text.trim(),
        id: widget.id,
        createdTime: DateTime.now());
    if (titlecontroller.text.trim().isEmpty &&
        descriptioncontroller.text.trim().isEmpty) {
      return;
    } else {
      await FirebaseApi.updateNote(note);
    }
  }
}
