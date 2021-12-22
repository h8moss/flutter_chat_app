import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/common/services/firestore_server.dart';

class HomeStateProvider extends ChangeNotifier {
  HomeStateProvider(this.fireStoreServer)
      : __currentScroll = 0,
        __canSendMessage = true;

  final FireStoreServer fireStoreServer;

  double __currentScroll;
  bool __canSendMessage;

  set currentScroll(double value) {
    __currentScroll = value;
    notifyListeners();
  }

  set _canSendMessage(bool value) {
    __canSendMessage = value;
    notifyListeners();
  }

  bool get showJumpDownButton => __currentScroll > 100;

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Write a message here';
    }
    if (!__canSendMessage) {
      return 'You must wait at least 30 seconds between messages';
    }
    return null;
  }

  Future<void> sendMessage(String message) async {
    if (__canSendMessage) {
      await fireStoreServer.sendMessage(message);
    }
    setCanSendMessage();
  }

  Future<void> setCanSendMessage() async {
    _canSendMessage = false;
    await Future.delayed(const Duration(seconds: 30));
    _canSendMessage = true;
  }
}
