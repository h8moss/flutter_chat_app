import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlatformText extends StatelessWidget {
  const PlatformText(this.text, {Key? key, this.style, this.textAlign})
      : super(key: key);

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: ((context, sizingInformation) => sizingInformation.isDesktop
            ? _buildSelectableText(context)
            : _buildNormalText(context)));
  }

  Widget _buildNormalText(context) => Text(
        text,
        style: style,
        textAlign: textAlign,
      );

  Widget _buildSelectableText(context) => SelectableText(
        text,
        style: style,
        textAlign: textAlign,
      );
}
