import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class SelectCardItem extends StatefulWidget {
  const SelectCardItem(
      {Key? key, this.selectedIndex, required this.onChanged, required this.cards, required this.title})
      : super(key: key);
  final String title;
  final int? selectedIndex;
  final Function(int) onChanged;
  final List<List<String>> cards;

  @override
  State<SelectCardItem> createState() => _SelectCardItemState();
}

class _SelectCardItemState extends State<SelectCardItem> {
  int? _selectedIndex;

  void _changeSelect(int index) {
    setState(() => _selectedIndex = index);
    widget.onChanged(index);
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: menuTextStyle),
        SizedBox(height: 8),
        ...List.generate(
          widget.cards.length,
          (index) => GestureDetector(
            onTap: () => _changeSelect(index),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: index == (_selectedIndex ?? -1) ? primaryColor : Colors.white,
                  border: index == (_selectedIndex ?? -1) ? null : Border.all(color: Colors.grey, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.cards[index][0], style: settingsText1),
                    Text(widget.cards[index][1], style: descTextStyle),
                  ],
                ),
              ),
            ),
          ),
        )
      ].toList(),
    );
  }
}
