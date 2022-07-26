import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubButton extends StatelessWidget {
  const SubButton({
    Key? key,
    required this.icon,
    required this.position,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
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
        child: Container(
          padding: position == 'L' ? EdgeInsets.only(right: 16) : EdgeInsets.only(left: 16),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            color: onPressed == null ? Colors.grey : Color(0xFF111827),
          ),
        ),
      ),
    );
  }
}
