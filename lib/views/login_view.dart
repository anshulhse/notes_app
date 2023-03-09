import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login view"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 250, 10, 0),
          child: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    // ignore: prefer_const_constructors
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    // ignore: prefer_const_constructors
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: 'Enter your email id',
                ),
              ),
              Container(
                height: 11,
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    // ignore: prefer_const_constructors
                    borderSide: BorderSide(
                      color: Colors.deepOrange,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    // ignore: prefer_const_constructors
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.black,
                  ),
                  hintText: 'Enter your password',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().logIn(
                      email: email,
                      password: password,
                    );
                    final user = AuthService.firebase().currentUser;
                    if (user?.isEmailverified ?? false) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        notesRoute,
                        (route) => false,
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute,
                        (route) => false,
                      );
                    }
                  } on UserNotFoundAuthException {
                    await showErrorDialog(
                      context,
                      'user not found',
                    );
                  } on WrongPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'wrng passwd',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      'Authentication error',
                    );
                  }
                },
                child: const Text(
                  'Click here to login',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: const Text(
                  "New User ? Click here",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
