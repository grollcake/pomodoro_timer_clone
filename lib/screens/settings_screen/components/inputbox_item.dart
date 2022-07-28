import 'package:flutter/material.dart';
import 'package:pomodoro_timer_clone/constants/style.dart';

class InputBoxItem extends StatefulWidget {
  const InputBoxItem({Key? key, required this.title, this.desc, required this.defalutValue}) : super(key: key);
  final String title;
  final String? desc;
  final String? defalutValue;

  @override
  State<InputBoxItem> createState() => _InputBoxItemState();
}

class _InputBoxItemState extends State<InputBoxItem> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.defalutValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: menuTextStyle),
                if (widget.desc != null) Text(widget.desc!, style: descTextStyle),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
              style: menuTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
