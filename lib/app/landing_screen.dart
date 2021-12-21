import 'package:flutter/material.dart';
import 'package:flutter_chat_app/common/models/auth_state.dart';
import 'package:flutter_chat_app/common/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'login_page.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (_) => AuthService(),
      child: Consumer<AuthService>(
        builder: (context, authService, _) => StreamBuilder<AuthState>(
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.data == AuthState.authenticating) {
              return _buildLoadingPage();
            }
            if (snapshot.data == AuthState.authenticated) {
              return const HomePage();
            }
            return const LoginPage();
          },
          stream: authService.authState,
        ),
      ),
    );
  }

  Scaffold _buildLoadingPage() =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
