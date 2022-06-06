import 'package:flutter/material.dart';

import '../core/api/firebase_api.dart';
import '../core/models/note_model.dart';
import '../theme/theme.dart';
import 'home_screen.dart';
import 'widgets/common_widgets.dart';

class AddNotes extends StatefulWidget {
  const AddNotes(
      {this.id,
      this.title,
      this.description,
      this.time,
      this.isedit = false,
      Key? key})
      : super(key: key);
  final String? title;
  final String? description;
  final String? id;
  final DateTime? time;
  final bool isedit;

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
        bottomNavigationBar: Container(
            width: double.infinity,
            height: 40,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowminspace,
                  const SizedBox(
                    width: 45,
                  ),
                  Text(widget.time == null
                      ? "Created ${DateTime.now().hour}:${DateTime.now().minute}"
                      : "Last edited ${widget.time!.hour}:${widget.time!.minute}"),
                  widget.time != null
                      ? const SizedBox(
                          width: 85,
                        )
                      : const SizedBox(width: 115),
                ],
              ),
            )),
        backgroundColor: white,
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
