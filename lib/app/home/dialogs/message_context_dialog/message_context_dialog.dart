import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/home/dialogs/message_context_dialog/message_context_choice.dart';

class MessageContextDialog extends StatelessWidget {
  const MessageContextDialog({Key? key, required this.isByUser})
      : super(key: key);

  static Future<MessageContextChoice?> show(
      BuildContext context, bool isByUser) {
    return showDialog<MessageContextChoice>(
        context: context,
        builder: (context) => MessageContextDialog(isByUser: isByUser));
  }

  final bool isByUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isByUser)
              TextButton(
                  onPressed: () => Navigator.pop(
                        context,
                        MessageContextChoice.delete,
                      ),
                  child: const Text('Delete')),
            isByUser
                ? TextButton(
                    onPressed: () => Navigator.pop(
                          context,
                          MessageContextChoice.edit,
                        ),
                    child: const Text('Edit'))
                : TextButton(
                    onPressed: () => Navigator.pop(
                          context,
                          MessageContextChoice.flag,
                        ),
                    child: const Text('Flag as inappropriate')),
          ],
        ),
      ),
    );
  }
}
