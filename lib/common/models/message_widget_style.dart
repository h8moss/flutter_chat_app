import 'package:flutter/material.dart';

class MessageWidgetStyle {
  const MessageWidgetStyle({
    this.alignment = CrossAxisAlignment.start,
    this.backgroundColor = Colors.blue,
    this.inkColor = Colors.grey,
    this.padding = 0,
    this.radius = 0,
    this.leftUserPadding = 0,
    this.rightUserPadding = 0,
    this.usernameStyle,
    this.mainTextStyle,
    this.buttonStyle,
  });

  const MessageWidgetStyle.base()
      : alignment = CrossAxisAlignment.start,
        backgroundColor = Colors.blue,
        inkColor = Colors.grey,
        buttonStyle = null,
        mainTextStyle = null,
        padding = 8,
        radius = 30,
        leftUserPadding = 0,
        rightUserPadding = 0,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey);

  MessageWidgetStyle.byOther()
      : alignment = CrossAxisAlignment.start,
        backgroundColor = Colors.grey.shade300,
        inkColor = Colors.grey.shade400,
        buttonStyle = const TextStyle(color: Colors.red),
        leftUserPadding = 8,
        mainTextStyle = null,
        padding = 8,
        radius = 30,
        rightUserPadding = 0,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey);

  MessageWidgetStyle.byUser()
      : alignment = CrossAxisAlignment.end,
        backgroundColor = Colors.blue,
        inkColor = Colors.blue.shade600,
        buttonStyle = const TextStyle(color: Colors.red),
        leftUserPadding = 0,
        mainTextStyle = const TextStyle(color: Colors.white),
        padding = 8,
        radius = 30,
        rightUserPadding = 8,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey);

  final CrossAxisAlignment alignment;
  final TextStyle? usernameStyle;
  final TextStyle? mainTextStyle;
  final TextStyle? buttonStyle;
  final double padding;
  final double radius;
  final double leftUserPadding;
  final double rightUserPadding;
  final Color backgroundColor;
  final Color inkColor;
}