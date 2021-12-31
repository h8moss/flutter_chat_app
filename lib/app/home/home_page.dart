import 'package:flutter/material.dart';
import 'package:flutter_chat_app/app/home/home_state_provider.dart';
import 'package:flutter_chat_app/app/messages/message_widget.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';
import 'package:flutter_chat_app/common/models/message_widget_style.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';
import 'package:provider/provider.dart';

import '../messages/message_input.dart';
import '../messages/message_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage._({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  static Widget create(BuildContext context) {
    return Provider<FireStoreServer>(
      create: (context) => FireStoreServer(
          Provider.of<AuthService>(context, listen: false).currentUser!),
      child: Consumer<FireStoreServer>(
        builder: (context, server, _) =>
            ChangeNotifierProvider<HomeStateProvider>(
          create: (_) => HomeStateProvider(server),
          child: const HomePage._(),
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  final ScrollController _messageScroll = ScrollController();
  final TextEditingController _messageTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStateProvider>(
      builder: (context, homeState, _) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Chat'),
              actions: [
                TextButton(
                    onPressed: () =>
                        Provider.of<AuthService>(context, listen: false)
                            .logOut(),
                    child: const Icon(Icons.logout, color: Colors.white))
              ],
            ),
            floatingActionButton: _buildFloatActionButton(homeState),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            body: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: MessageListView(
                            scrollController: _messageScroll,
                            onDelete: (msg) => _showDeleteDialog(context, msg)),
                      ),
                    ],
                  ),
                ),
                MessageInput(
                  textController: _messageTextController,
                  onSubmit: () async {
                    if (_formKey.currentState!.validate()) {
                      await homeState.sendMessage(_messageTextController.text);
                      _jumpDown();
                      _messageTextController.text = '';
                    }
                  },
                  formKey: _formKey,
                  validateInput: homeState.validateMessage,
                ),
              ],
            ));
      },
    );
  }

  Column _buildFloatActionButton(HomeStateProvider homeState) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (homeState.showJumpDownButton)
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
    );
  }

  @override
  void dispose() {
    _messageScroll.dispose();
    _messageTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _messageScroll.addListener(() =>
        Provider.of<HomeStateProvider>(context, listen: false).currentScroll =
            _messageScroll.offset);

    super.initState();
  }

  void _jumpDown() {
    _messageScroll.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Future<void> _showDeleteDialog(
      BuildContext context, ChatMessage message) async {
    final homeState = Provider.of<HomeStateProvider>(context, listen: false);

    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Center(child: const Text('Do you wish to delete this message?')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: MessageWidget(
                  message: message,
                  onButtonPressed: null,
                  style: MessageWidgetStyle.byUser(),
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No')),
                TextButton(
                    onPressed: () async {
                      await homeState.deleteMessage(message);
                      Navigator.pop(context);
                    },
                    child: const Text('yes'))
              ],
            )
          ],
        );
      },
    );
  }
}
