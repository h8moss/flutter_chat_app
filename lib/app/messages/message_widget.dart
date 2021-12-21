import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/app_user.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key, required this.message, required this.currentUser})
      : super(key: key);

  final ChatMessage message;
  final AppUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: message.sender == currentUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender.username,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: message.sender == currentUser
                    ? Colors.blue
                    : Colors.grey.shade400,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message.text,
                  style: TextStyle(
                      color: message.sender == currentUser
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
