import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'detail_screen.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  static const path = '/a';
  static const name = 'A';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Screen A',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Screen A'),
            TextButton(
              onPressed: () {
                GoRouter.of(context)
                    .go('${ScreenA.location}/${DetailsScreen.location}');
              },
              child: const Text('View A details'),
            ),
          ],
        ),
      ),
    );
  }
}
