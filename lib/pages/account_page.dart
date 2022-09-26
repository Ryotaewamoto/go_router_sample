import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'product_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  static const path = '/account';
  static const name = 'Account';
  static const location = path;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                GoRouter.of(context)
                    .go('${AccountPage.location}/${ProductPage.location}');
              },
              child: const Text('View B details'),
            ),
          ],
        ),
      ),
    );
  }
}
