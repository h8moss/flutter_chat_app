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
  }) : super(key: key);

  final ChatMessage message;
  final MessageWidgetStyle style;
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
                    right: style.rightUserPadding,
                  ),
                  child: Text(
                    message.sender.username,
                    style: style.usernameStyle,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (sizingInformation.isDesktop && style.isContextOnLeft)
                      _buildContextButton(),
                    Flexible(
                      child: InkWell(
                        borderRadius:
                            BorderRadius.all(Radius.circular(style.radius)),
                        highlightColor: style.inkColor,
                        onLongPress: !sizingInformation.isDesktop
                            ? onButtonPressed
                            : null,
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
                    ),
                    if (sizingInformation.isDesktop && !style.isContextOnLeft)
                      _buildContextButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildContextButton() {
    return InkWell(
        onTap: onButtonPressed,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.more_horiz,
            color: Colors.grey,
          ),
        ));
  }
}
