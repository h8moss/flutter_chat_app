import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/home/dialogs/message_context_dialog/message_context_choice.dart';

class MessageContextDialog extends StatelessWidget {
  const MessageContextDialog({Key? key}) : super(key: key);

  static Future<MessageContextChoice?> show(BuildContext context) {
    return showDialog<MessageContextChoice>(
        context: context, builder: (context) => const MessageContextDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(
                      context,
                      MessageContextChoice.delete,
                    ),
                child: const Text('Delete')),
            TextButton(
                onPressed: () => Navigator.pop(
                      context,
                      MessageContextChoice.edit,
                    ),
                child: const Text('Edit'))
          ],
        ),
      ),
    );
  }
}
