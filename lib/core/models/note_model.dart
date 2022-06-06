class NoteField {
  static const createdTime = 'createdTime';
}

class Note {
  String? id;
  DateTime? createdTime;
  String? title;
  String? description;
  bool pinned;
  Note({this.id, this.createdTime, this.title, this.description,this.pinned=false});
  Map<String, dynamic> toJson() => {
        'createdTime': createdTime!.toUtc(),
        'id': id,
        'title': title,
        'description': description,
        'pinned': pinned,
      };
  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        createdTime: json['createdTime'].toDate(),
        title: json['title'],
        description: json['description'],
        pinned: json['pinned'],
      );
}
