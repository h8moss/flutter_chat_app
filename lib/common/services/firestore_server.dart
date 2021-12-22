import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/common/models/app_user.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';

class FireStoreServer {
  FireStoreServer(this.currentUser);

  final AppUser currentUser;

  // Stream<List<ChatMessage>> get messages;

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<void> sendMessage(String text) async {
    ChatMessage message =
        ChatMessage(sender: currentUser, sentDate: DateTime.now(), text: text);

    await _firestore.collection('messages').add(message.toMap());
  }

  Stream<List<ChatMessage>> get messages => _firestore
      .collection('messages')
      .orderBy('sent', descending: true)
      .snapshots()
      .map<List<ChatMessage>>((event) =>
          event.docs.map((e) => ChatMessage.fromJson(e.data())).toList());
}
