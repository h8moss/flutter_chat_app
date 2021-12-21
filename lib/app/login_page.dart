import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
