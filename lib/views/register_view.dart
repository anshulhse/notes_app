import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import '../services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text("Register view"),
      ),
      body: Padding(
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
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'weak pass',
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                    context,
                    'email-already-in-use',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'invalid-email',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'failed to register',
                  );
                }
              },
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text(
                "already register? login here",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
