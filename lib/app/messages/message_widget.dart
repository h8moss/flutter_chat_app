import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/chat_message.dart';
import 'package:flutter_chat_app/common/models/message_widget_style.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
    required this.message,
    required this.onButtonPressed,
    this.style = const MessageWidgetStyle(),
    this.buttonLabel,
  }) : super(key: key);

  final ChatMessage message;
  final MessageWidgetStyle style;
  final String? buttonLabel;
  final FutureOr<void> Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: style.alignment,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: style.leftUserPadding,
                      right: style.rightUserPadding),
                  child: Text(
                    message.sender.username,
                    style: style.usernameStyle,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(style.radius)),
                  highlightColor: style.inkColor,
                  onLongPress:
                      sizingInformation.isDesktop ? null : onButtonPressed,
                  child: Ink(
                    child: Padding(
                      padding: EdgeInsets.all(style.padding),
                      child: Text(
                        message.text,
                        style: style.mainTextStyle,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: style.backgroundColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(style.radius)),
                    ),
                  ),
                ),
                if (buttonLabel != null)
                  sizingInformation.isDesktop
                      ? TextButton(
                          onPressed: onButtonPressed,
                          child: Text(
                            buttonLabel!,
                            style: style.buttonStyle,
                          ))
                      : Container(),
              ],
            ),
          ),
        ],
      );
    });
  }
}
