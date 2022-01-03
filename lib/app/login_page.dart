import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:flutter_chat_app/common/services/url_launcher/url_launcher_others.dart'
    if (dart.library.html) 'package:flutter_chat_app/common/services/url_launcher/url_launcher_web.dart'
    as url_launcher;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            const Text(
              "Welcome to h8m0ss's chat app, before you start chatting, you need to log in",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.resolveWith((states) =>
                        states.contains(MaterialState.hovered)
                            ? BorderSide(color: Colors.grey.shade600, width: 2)
                            : const BorderSide(color: Colors.grey, width: 1))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset('assets/google.png'),
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Continue with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                onPressed: () => _logIn(context),
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      'This app was made by h8m0ss for the purpose of demonstrating basic flutter and firebase concepts.',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: TextButton(
                      child: Image.asset('assets/github.png'),
                      onPressed: () => url_launcher.launchUrl(
                          'https://github.com/h8moss/flutter_chat_app')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _logIn(BuildContext context) async {
    try {
      await Provider.of<AuthService>(context, listen: false).logInWithGoogle();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
