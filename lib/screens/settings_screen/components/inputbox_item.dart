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
  bool _formatError = false;

  void _validateUserInput() {
    if (RegExp(r'^[0-9]{1,2}:[0-9]{1,2}$').hasMatch(_controller.text)) {
      setState(() => _formatError = false);
    } else {
      setState(() => _formatError = true);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.defalutValue ?? '';
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.defalutValue != oldWidget.defalutValue) _controller.text = widget.defalutValue ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  onChanged: (value) => _validateUserInput(),
                ),
              ),
            ],
          ),
          if (_formatError)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color(0xFFFDE047),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded),
                  SizedBox(width: 8),
                  Text('Incorrectly formatted time (MM:SS)', style: descTextStyle),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
