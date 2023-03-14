import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';

@immutable
class AuthUser {
  final String? email;
  final bool isEmailverified;
  const AuthUser({required this.email, required this.isEmailverified});

  factory AuthUser.fromFirebase(User user) =>
      AuthUser(email: user.email, isEmailverified: user.emailVerified);
}

// class MyAuthUser extends AuthUser {
//   MyAuthUser(bool isEmailVerified) : super(isEmailVerified);
// }
