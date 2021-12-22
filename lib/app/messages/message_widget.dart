import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/app_user.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key, required this.message, required this.currentUser})
      : super(key: key);

  final ChatMessage message;
  final AppUser currentUser;

  bool get isCurrentUser => message.sender == currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.sender.username,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isCurrentUser) Flexible(child: Container(), flex: 5),
              Flexible(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: isCurrentUser ? Colors.blue : Colors.grey.shade400,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      message.text,
                      style: TextStyle(
                          color: isCurrentUser ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
              if (!isCurrentUser) Flexible(child: Container(), flex: 5)
            ],
          ),
        ],
      ),
    );
  }
}
