import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  AppUser({required this.uid, required this.username});

  factory AppUser.fromFirebase(User user) {
    return AppUser(uid: user.uid, username: user.displayName ?? 'anonymous');
  }

  final String uid;
  final String username;

  @override
  operator ==(Object other) {
    return other is AppUser ? other.uid == uid : false;
  }

  @override
  int get hashCode => uid.hashCode;
}
