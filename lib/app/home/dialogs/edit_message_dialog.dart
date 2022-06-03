import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditMessageDialog extends StatefulWidget {
  const EditMessageDialog({Key? key, required this.initialText})
      : super(key: key);

  final String initialText;

  static Future<String?> show(BuildContext context, String initialText) {
    return showDialog<String>(
        context: context,
        builder: (context) => EditMessageDialog(initialText: initialText));
  }

  @override
  State<EditMessageDialog> createState() => _EditMessageDialogState();
}

class _EditMessageDialogState extends State<EditMessageDialog> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.initialText;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Message'),
      content: TextField(controller: _controller),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, _controller.text),
            child: const Text('Done')),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
      ],
    );
  }
}
