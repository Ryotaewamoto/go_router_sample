import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth.dart';
import 'sign_in_page.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const path = '/account';
  static const name = 'Account';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Account',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen B'),
            TextButton(
              onPressed: () async {
                GoRouter.of(context).go(SignInPage.location);
              },
              child: const Text('ログイン'),
            ),
            TextButton(
              onPressed: () async {
                await ref.read(signOutProvider)();
                print(FirebaseAuth.instance.currentUser != null);
              },
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
