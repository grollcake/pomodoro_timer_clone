import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
    required this.icon,
    required this.position,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String position;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 70,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2.0,
            padding: EdgeInsets.zero,
            primary: Color(0xFFE5E7EB),
          ),
          child: Padding(
            padding: position == 'L' ? EdgeInsets.only(right: 16) : EdgeInsets.only(left: 16),
            child: Icon(
              icon,
              size: 30,
              color: Color(0xFF111827),
            ),
          ),
        ));
  }
}
