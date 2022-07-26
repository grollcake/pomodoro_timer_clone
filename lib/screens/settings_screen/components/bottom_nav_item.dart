import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class BottomNavItem extends StatefulWidget {
  const BottomNavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);
  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.isActive ? 5 : 3,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: widget.isActive ? primaryColor : menuInactiveColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon,
                if (widget.isActive) SizedBox(width: 6),
                if (widget.isActive) Text(widget.label, style: menuTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
