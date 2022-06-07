import 'package:flutter/material.dart';

class NoteField {
  static const createdTime = 'createdTime';
}

class Note {
  String? id;
  DateTime? createdTime;
  String? title;
  String? description;
  int? color;

  Note(
      {this.id,
      this.createdTime,
      this.title,
      this.description,
      this.color});
  Map<String, dynamic> toJson() => {
        'createdTime': createdTime!.toUtc(),
        'id': id,
        'title': title,
        'description': description,
        'color': color,
      };
  static Note fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        createdTime: json['createdTime'].toDate(),
        title: json['title'],
        description: json['description'],
        color: json['color'],
      );
}
