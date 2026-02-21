import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/common/models/app_user.dart';
import 'package:flutter_chat_app/common/models/auth_state.dart';

class AuthService {
  AuthService() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user == null) {
        _authStateController.add(AuthState.unauthenticated);
      } else {
        _authStateController.add(AuthState.authenticated);
      }
    });
  }
  User? get _firebaseUser => FirebaseAuth.instance.currentUser;

  AppUser? get currentUser =>
      _firebaseUser != null ? AppUser.fromFirebase(_firebaseUser!) : null;

  final GoogleAuthProvider _googleAuth = GoogleAuthProvider();

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> logInWithGoogle() async {
    _authStateController.add(AuthState.authenticating);

    try {
      if (kIsWeb) {
        await _googleLogInWeb();
      } else if (Platform.isAndroid) {
        await _googleLogInAndroid();
      }
      _authStateController.add(AuthState.authenticated);
    } catch (e) {
      _authStateController.add(AuthState.unauthenticated);
      rethrow;
    }
  }

  Future<void> loginAnonymous() async {
    _authStateController.add(AuthState.authenticating);

    try {
      await FirebaseAuth.instance.signInAnonymously();
      _authStateController.add(AuthState.anonymouslyAuthenticated);
    } catch (e) {
      _authStateController.add(AuthState.unauthenticated);
      rethrow;
    }
  }

  Future<void> _googleLogInAndroid() async {
    // final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
    // 
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;
    // 
    // final creds = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
    // 
    // await FirebaseAuth.instance.signInWithCredential(creds);
  }

  Future<void> _googleLogInWeb() async {
    await FirebaseAuth.instance.signInWithPopup(_googleAuth);
  }

  final StreamController<AuthState> _authStateController =
      StreamController<AuthState>();

  Stream<AuthState> get authState => _authStateController.stream;
}
