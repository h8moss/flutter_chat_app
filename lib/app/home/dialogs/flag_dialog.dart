import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlagDialog extends StatelessWidget {
  const FlagDialog({Key? key}) : super(key: key);

  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
            context: context, builder: (context) => const FlagDialog()) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('WIP, this button does nothing :)'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm')),
        TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'))
      ],
    );
  }
}
