import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'detail_screen.dart';

class ScreenB extends StatelessWidget {
  const ScreenB({Key? key}) : super(key: key);

  static const path = '/b';
  static const name = 'B';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Screen B',
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
                GoRouter.of(context).go('${ScreenB.location}/${DetailsScreen.location}');
              },
              child: const Text('View B details'),
            ),
          ],
        ),
      ),
    );
  }
}
