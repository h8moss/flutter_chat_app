import 'package:flutter/material.dart';

class MessageWidgetStyle {
  const MessageWidgetStyle({
    this.alignment = CrossAxisAlignment.start,
    this.showContextButton = true,
    this.backgroundColor = Colors.blue,
    this.inkColor = Colors.grey,
    this.padding = 0,
    this.radius = 0,
    this.leftUserPadding = 0,
    this.rightUserPadding = 0,
    this.usernameStyle,
    this.mainTextStyle,
  });

  const MessageWidgetStyle.base()
      : alignment = CrossAxisAlignment.start,
        backgroundColor = Colors.blue,
        inkColor = Colors.grey,
        mainTextStyle = null,
        padding = 8,
        radius = 30,
        leftUserPadding = 0,
        rightUserPadding = 0,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey),
        showContextButton = true;

  MessageWidgetStyle.byOther()
      : alignment = CrossAxisAlignment.start,
        backgroundColor = Colors.grey.shade300,
        inkColor = Colors.grey.shade400,
        leftUserPadding = 8,
        mainTextStyle = null,
        padding = 8,
        radius = 30,
        rightUserPadding = 0,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey),
        showContextButton = false;

  MessageWidgetStyle.byUser()
      : alignment = CrossAxisAlignment.end,
        backgroundColor = Colors.blue,
        inkColor = Colors.blue.shade600,
        leftUserPadding = 0,
        mainTextStyle = const TextStyle(color: Colors.white),
        padding = 8,
        radius = 30,
        rightUserPadding = 8,
        usernameStyle = const TextStyle(fontSize: 10, color: Colors.grey),
        showContextButton = true;

  /// Horizontal alignment of the message
  final CrossAxisAlignment alignment;

  /// Text style for the username and edited texts
  final TextStyle? usernameStyle;

  /// Text style for the message itself
  final TextStyle? mainTextStyle;

  /// Padding inside the message bubble
  final double padding;

  /// Radius of message bubble
  final double radius;

  // bubble padding to the left of the screen
  final double leftUserPadding;

  /// bubble padding to the right of the screen
  final double rightUserPadding;

  /// Color of the bubble
  final Color backgroundColor;

  /// Color of the ink splash
  final Color inkColor;

  /// True if context button should appear on desktop
  final bool showContextButton;
}
