import 'package:flutter/material.dart';

class SubButton extends StatelessWidget {
  const SubButton({
    Key? key,
    required this.icon,
    required this.position,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String position;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFE5E7EB),
          borderRadius: position == 'L'
              ? BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))
              : BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
        ),
        child: Padding(
          padding: position == 'L' ? EdgeInsets.only(right: 16) : EdgeInsets.only(left: 16),
          child: Icon(
            icon,
            size: 30,
            color: onPressed == null ? Colors.grey : Color(0xFF111827),
          ),
        ),
      ),
    );
  }
}
