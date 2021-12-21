import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';
import 'package:provider/provider.dart';

import 'messages/message_input.dart';
import 'messages/message_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _messageScroll = ScrollController();

  @override
  void initState() {
    _messageScroll.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    _messageScroll.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<FireStoreServer>(
      create: (_) =>
          FireStoreServer(Provider.of<AuthService>(context).currentUser!),
      child: Consumer<FireStoreServer>(
        builder: (context, firestoreServer, _) {
          return _buildMethod(firestoreServer);
        },
      ),
    );
  }

  bool get _showJumpDownButton =>
      _messageScroll.hasClients && _messageScroll.offset > 50;

  Scaffold _buildMethod(FireStoreServer firestoreServer) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            TextButton(
                onPressed: () =>
                    Provider.of<AuthService>(context, listen: false).logOut(),
                child: const Icon(Icons.logout, color: Colors.white))
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (_showJumpDownButton)
              FloatingActionButton(
                onPressed: _jumpDown,
                child: const Icon(Icons.arrow_drop_down),
                mini: true,
                backgroundColor: Colors.grey.shade600,
              ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Column(
          children: [
            Expanded(
              child: MessageListView(
                scrollController: _messageScroll,
              ),
            ),
            MessageInput(onSubmit: (v) => _sendMessage(firestoreServer, v)),
          ],
        ));
  }

  void _sendMessage(FireStoreServer server, String value) {
    if (value.isNotEmpty) {
      server.sendMessage(value);

      _jumpDown();
    }
  }

  void _jumpDown() {
    _messageScroll.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
