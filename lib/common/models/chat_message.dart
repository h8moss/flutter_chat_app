import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/common/models/app_user.dart';

class ChatMessage {
  ChatMessage({
    required this.sender,
    required this.sentDate,
    required this.text,
    required this.isEdited,
    this.id,
  });

  /// returns a map of this message for firestore
  Map<String, dynamic> toMap() {
    return {
      'sent': sentDate,
      'text': text,
      'sender': sender.uid,
      'username': sender.username,
      'is_edited': isEdited,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json, String id) {
    return ChatMessage(
      sender: AppUser(
          uid: json['sender'], username: json['username'] ?? 'anonymous'),
      sentDate: (json['sent'] as Timestamp).toDate(),
      text: json['text'],
      id: id,
      isEdited: json['isEdited'] ?? false,
    );
  }

  final AppUser sender;
  final DateTime sentDate;
  final String text;
  final String? id;
  final bool isEdited;
}
