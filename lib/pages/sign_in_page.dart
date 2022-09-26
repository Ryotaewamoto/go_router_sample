import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static const path = '/sign-in';
  static const name = 'SignIn';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text('Sign In'),
          onPressed: () async {
            await ref.read(signInAnonymouslyProvider)();
            print(FirebaseAuth.instance.currentUser != null);
          },
        ),
      ),
    );
  }
}
