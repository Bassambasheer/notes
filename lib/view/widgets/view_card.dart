import 'package:flutter/material.dart';
import 'package:notez/core/constantwidgets/textwidget.dart';
import 'package:notez/theme/theme.dart';

import '../add_notes screen.dart';
import 'common_widgets.dart';

class ViewCard extends StatelessWidget {
  const ViewCard(
      {this.title,
      this.description,
      this.id,
      this.time,
      this.color = 0XFFFFFFFF,
      Key? key})
      : super(key: key);
  final String? title;
  final String? description;
  final String? id;
  final DateTime? time;
  final int? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        onTap: (() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AddNotes(
                    title: title,
                    description: description,
                    id: id,
                    time: time,
                    isedit: true,
                  )));
        }),
        child: Container(
          decoration: BoxDecoration(
            color: Color(color!),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title.toString().isEmpty
                    ? const SizedBox()
                    : Text(
                        title ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                minspace,
                description.toString().isEmpty
                    ? const SizedBox()
                    : Text(description ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                Container(
                  child: TextWidget(
                      txt: "${time!.day}${time!.hour}:${time!.minute}"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
