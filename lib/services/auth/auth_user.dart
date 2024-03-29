import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  final String id;
  final String? email;
  final bool isEmailverified;
  const AuthUser(
      {required this.id, required this.email, required this.isEmailverified});

  factory AuthUser.fromFirebase(User user) => AuthUser(
      id: user.uid, email: user.email!, isEmailverified: user.emailVerified);
}

// class MyAuthUser extends AuthUser {
//   MyAuthUser(bool isEmailVerified) : super(isEmailVerified);
// }
