import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pomodoro_timer_clone/screens/settings_screen/components/bottom_nav_item.dart';

class BottomNavSection extends StatefulWidget {
  const BottomNavSection({Key? key, required this.callBack, required this.initialIndex}) : super(key: key);
  final int initialIndex;
  final Function(int) callBack;

  @override
  State<BottomNavSection> createState() => _BottomNavSectionState();
}

class _BottomNavSectionState extends State<BottomNavSection> {
  late int _menuIndex;

  @override
  void initState() {
    super.initState();
    _menuIndex = widget.initialIndex;
  }

  void _bottomMenuSelect(int index) {
    setState(() => _menuIndex = index);
    widget.callBack(index);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            icon: SvgPicture.asset('assets/icons/icon-tabler-adjustments.svg'),
            label: 'Main',
            isActive: _menuIndex == 0,
            onPressed: () => _bottomMenuSelect(0),
          ),
          BottomNavItem(
            icon: SvgPicture.asset('assets/icons/icon-tabler-alarm.svg'),
            label: 'Schedule',
            isActive: _menuIndex == 1,
            onPressed: () => _bottomMenuSelect(1),
          ),
          BottomNavItem(
            icon: SvgPicture.asset('assets/icons/icon-tabler-artboard.svg'),
            label: 'Display',
            isActive: _menuIndex == 2,
            onPressed: () => _bottomMenuSelect(2),
          ),
          BottomNavItem(
            icon: SvgPicture.asset('assets/icons/icon-tabler-info-circle.svg'),
            label: 'About',
            isActive: _menuIndex == 3,
            onPressed: () => _bottomMenuSelect(3),
          ),
        ],
      ),
    );
  }
}
