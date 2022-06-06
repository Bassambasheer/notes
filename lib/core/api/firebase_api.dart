import 'package:cloud_firestore/cloud_firestore.dart';
import '../../view/login_screen.dart';
import '../models/note_model.dart';

class FirebaseApi {
  static Future<String> createNote(Note note) async {
    final docnote = FirebaseFirestore.instance.collection(user!.email).doc();
    note.id = docnote.id;
    await docnote.set(note.toJson());
    return docnote.id;
  }

  static Stream<List<Note>> getNote() =>
      FirebaseFirestore.instance.collection(user!.email).snapshots().map((event) =>
          event.docs.map((json) => Note.fromJson(json.data())).toList());

  static Future updateNote(Note note) async {
    final docnote = FirebaseFirestore.instance.collection(user!.email).doc(note.id);
    await docnote.update(note.toJson());
  }

  static Future deleteNote(String id) async {
    final docnote = FirebaseFirestore.instance.collection(user!.email).doc(id);
    await docnote.delete();
  }
}
