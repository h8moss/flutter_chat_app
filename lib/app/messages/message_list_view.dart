import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';
import 'package:flutter_chat_app/common/models/message_widget_style.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class MessageListView extends StatefulWidget {
  const MessageListView({Key? key, this.scrollController, this.onDelete})
      : super(key: key);

  final ScrollController? scrollController;
  final Future<void> Function(ChatMessage)? onDelete;

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
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              reverse: true,
              controller: widget.scrollController,
              itemBuilder: (context, index) {
                bool isCurrentUser =
                    Provider.of<AuthService>(context).currentUser! ==
                        snapshot.data![index].sender;
                return Row(
                  children: [
                    if (isCurrentUser) Flexible(child: Container(), flex: 6),
                    Flexible(
                      flex: 5,
                      child: MessageWidget(
                        message: snapshot.data![index],
                        style: isCurrentUser
                            ? MessageWidgetStyle.byUser()
                            : MessageWidgetStyle.byOther(),
                        buttonLabel: isCurrentUser && widget.onDelete != null
                            ? 'Delete'
                            : null,
                        onButtonPressed: () =>
                            widget.onDelete!(snapshot.data![index]),
                      ),
                    ),
                    if (!isCurrentUser) Flexible(child: Container(), flex: 6),
                  ],
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
