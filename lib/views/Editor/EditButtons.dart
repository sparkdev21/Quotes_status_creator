import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback ontap;
  final VoidCallback onLongPress;

  final IconData icon;
  final Color? color;
  final String title;
  const EditButton({
    Key? key,
    required this.ontap,
    required this.onLongPress,
    required this.title,
    required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      onLongPress: onLongPress,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          Text(title)
        ],
      ),
    );
  }
}

class BoolenValue {
  bool value;
  BoolenValue(this.value);
}
