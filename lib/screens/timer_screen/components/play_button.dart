import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          elevation: 2.0,
          padding: EdgeInsets.zero,
          primary: Color(0xFFE5E7EB),
        ),
        child: SvgPicture.asset(
          icon,
          width: 60,
          height: 60,
          color: Color(0xFF111827),
        ),
      ),
    );
  }
}
