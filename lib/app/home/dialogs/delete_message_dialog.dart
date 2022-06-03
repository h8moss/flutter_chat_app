import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteMessageDialog extends StatelessWidget {
  const DeleteMessageDialog({Key? key}) : super(key: key);

  static Future<bool> show(BuildContext context) async {
    return await showDialog(
            context: context,
            builder: (context) => const DeleteMessageDialog()) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to delete this message?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ))
      ],
    );
  }
}
