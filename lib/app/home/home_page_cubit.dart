import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/app/home/home_page_state.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({
    required FirestoreServer firestoreServer,
    required AuthService authService,
  })  : _firestoreServer = firestoreServer,
        _authService = authService,
        super(const HomePageState()) {
    _messageSubscription = _firestoreServer.messages.listen((value) {
      emit(state.copyWith(messages: value));
    });

    _messageSubscription.onError((error) {
      emit(state.copyWithNull(messages: true));
    });

    listviewScrollController.addListener(_onScroll);
  }

  final FirestoreServer _firestoreServer;
  final AuthService _authService;

  int secondsUntilNextMessage = 0;
  ScrollController listviewScrollController = ScrollController();

  late StreamSubscription<List<ChatMessage>> _messageSubscription;

  bool isMessageByUser(ChatMessage message) =>
      message.sender == _authService.currentUser!;

  Future<void> logout() async {
    await _authService.logOut();
  }

  Future<void> sendMessage(String messageContents) async {
    if (messageContents.isNotEmpty) {
      _firestoreServer.sendMessage(messageContents);
      _jumpDown();
      _countSecondsForMessage();
    }
  }

  void onFABPressed() => _jumpDown();

  void _jumpDown() {
    if (listviewScrollController.hasClients) {
      listviewScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> onMessagePressed(BuildContext context) async {}

  Future<void> _countSecondsForMessage() async {
    for (int i = 5; i >= 0; i--) {
      secondsUntilNextMessage = i;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) return 'Please fill out this field';
    if (secondsUntilNextMessage > 0) {
      return 'Wait $secondsUntilNextMessage seconds until next message';
    }
    return null;
  }

  @override
  Future<void> close() async {
    listviewScrollController.dispose();
    _messageSubscription.cancel();

    super.close();
  }

  void _onScroll() {
    if (listviewScrollController.hasClients) {
      bool shouldShowFAB = listviewScrollController.offset > 200;
      if (state.showFAB != shouldShowFAB) {
        emit(state.copyWith(showFAB: shouldShowFAB));
      }
    }
  }
}
