import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';

@immutable
class HomePageState {
  const HomePageState({
    this.messages,
    this.showFAB = false,
  });

  const HomePageState.required({
    required this.messages,
    required this.showFAB,
  });

  HomePageState copyWith({
    List<ChatMessage>? messages,
    bool? showFAB,
  }) {
    return HomePageState.required(
      messages: messages ?? this.messages,
      showFAB: showFAB ?? this.showFAB,
    );
  }

  HomePageState copyWithNull({bool messages = false}) {
    return HomePageState.required(
      messages: messages ? null : this.messages,
      showFAB: showFAB,
    );
  }

  final List<ChatMessage>? messages;
  final bool showFAB;
}
