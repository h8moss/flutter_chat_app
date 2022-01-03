import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(String url) async {
  await launch(url);
}
