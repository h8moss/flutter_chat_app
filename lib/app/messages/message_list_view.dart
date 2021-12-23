import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({Key? key, this.scrollController}) : super(key: key);

  final ScrollController? scrollController;

  @override
  State<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FireStoreServer>(builder: (context, firestore, _) {
      return StreamBuilder<List<ChatMessage>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text('ERROR'));
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              reverse: true,
              controller: widget.scrollController,
              itemBuilder: (context, index) {
                return MessageWidget(
                  message: snapshot.data![index],
                  currentUser: Provider.of<AuthService>(context).currentUser!,
                  onDelete: () => print('delete ${snapshot.data![index].text}'),
                  onReport: () => print('report ${snapshot.data![index].text}'),
                );
              },
              itemCount: snapshot.data!.length,
            ),
          );
        },
        stream: firestore.messages,
      );
    });
  }
}
