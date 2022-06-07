import 'package:flutter/material.dart';

class ColorChoiceCard extends StatelessWidget {
  const ColorChoiceCard({
    required this.color,
    required this.isSelected,
    Key? key,
  }) : super(key: key);
  final bool isSelected;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: isSelected
          ? const Icon(Icons.done, color: Colors.black)
          : const SizedBox(),
    );
  }
}