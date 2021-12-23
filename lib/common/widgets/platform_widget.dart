import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder? webBuilder;
  final WidgetBuilder? iosBuilder;
  final WidgetBuilder? androidBuilder;
  final WidgetBuilder? windowsBuilder;
  final WidgetBuilder? macOSBuilder;
  final WidgetBuilder? linuxBuilder;
  final WidgetBuilder? defaultBuilder;
  final WidgetBuilder? fuchsiaBuilder;

  const PlatformWidget({
    Key? key,
    this.webBuilder,
    this.iosBuilder,
    this.androidBuilder,
    this.windowsBuilder,
    this.macOSBuilder,
    this.linuxBuilder,
    this.defaultBuilder,
    this.fuchsiaBuilder,
  }) : super(key: key);

  const PlatformWidget.mobile({
    WidgetBuilder? mobileBuilder,
    this.defaultBuilder,
    Key? key,
  })  : webBuilder = null,
        iosBuilder = mobileBuilder,
        androidBuilder = mobileBuilder,
        windowsBuilder = null,
        macOSBuilder = null,
        linuxBuilder = null,
        fuchsiaBuilder = mobileBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getBuilder()(context);
  }

  WidgetBuilder _getBuilder() {
    if (kIsWeb) {
      return _getBuilderForPlatform(webBuilder, 'web');
    } else if (Platform.isIOS) {
      return _getBuilderForPlatform(iosBuilder, 'ios');
    } else if (Platform.isAndroid) {
      return _getBuilderForPlatform(androidBuilder, 'android');
    } else if (Platform.isWindows) {
      return _getBuilderForPlatform(windowsBuilder, 'windows');
    } else if (Platform.isMacOS) {
      return _getBuilderForPlatform(macOSBuilder, 'macOS');
    } else if (Platform.isLinux) {
      return _getBuilderForPlatform(linuxBuilder, 'linux');
    } else if (Platform.isFuchsia) {
      return _getBuilderForPlatform(fuchsiaBuilder, 'fuchsia');
    }
    if (defaultBuilder == null) {
      throw 'The current platform is not supported and you did not specify a default constructor';
    }
    return defaultBuilder!;
  }

  WidgetBuilder _getBuilderForPlatform(
      WidgetBuilder? builder, String platformName) {
    if (builder == null && defaultBuilder == null) _throwError(platformName);
    return builder ?? defaultBuilder!;
  }

  void _throwError(String platformName) {
    throw 'Could not find builder for $platformName, try specifying a [${platformName}Builder] or a [defaultBuilder]';
  }
}
