import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/app/home/home_page_cubit.dart';
import 'package:flutter_chat_app/app/home/home_page_state.dart';
import 'package:flutter_chat_app/common/widgets/message_widget.dart';
import 'package:flutter_chat_app/common/models/message_widget_style.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  HomePageCubit _cubitOf(BuildContext context) {
    return BlocProvider.of<HomePageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<AuthService>(context, listen: false).currentUser!;

    return Provider<FirestoreServer>(
      create: (_) => FirestoreServer(currentUser),
      child: BlocProvider<HomePageCubit>(
        create: (context) => HomePageCubit(
          authService: Provider.of<AuthService>(context, listen: false),
          firestoreServer: Provider.of<FirestoreServer>(context, listen: false),
        ),
        child: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomePageState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          TextButton(
              onPressed: _cubitOf(context).logout,
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: state.showFAB
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: _cubitOf(context).onFABPressed,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
                const SizedBox(height: 50)
              ],
            )
          : null,
      body: Column(
        children: [
          Expanded(child: _buildMessageListView(context, state)),
          _buildMessageInput(context, state),
        ],
      ),
    );
  }

  Widget _buildMessageListView(BuildContext context, HomePageState state) {
    if (state.messages == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.messages!.isEmpty) {
      return const Center(
          child: Text('No messages yet. Be the first to send a message!'));
    }

    return ListView.builder(
      reverse: true,
      controller: _cubitOf(context).listviewScrollController,
      itemCount: state.messages!.length,
      itemBuilder: (context, index) {
        final message = state.messages![index];
        final isByUser = _cubitOf(context).isMessageByUser(message);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: MessageWidget(
            message: message,
            onButtonPressed: isByUser
                ? () => _cubitOf(context).onMessagePressed(context)
                : null,
            buttonLabel: isByUser ? 'Delete' : null,
            style: isByUser
                ? MessageWidgetStyle.byUser()
                : MessageWidgetStyle.byOther(),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(BuildContext context, HomePageState state) {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onFieldSubmitted: (_) => _onSend(),
                controller: _textFieldController,
                validator: _cubitOf(context).validateMessage,
                onSaved: (msg) => _cubitOf(context).sendMessage(msg!),
                textInputAction: TextInputAction.none,
                decoration: InputDecoration(
                  hintText: 'Message',
                  fillColor: Colors.grey.shade400,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            )),
            ElevatedButton(onPressed: _onSend, child: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }

  void _onSend() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _textFieldController.text = '';
    }
  }
}
