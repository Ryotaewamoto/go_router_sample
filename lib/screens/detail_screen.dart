import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The details screen for either the A or B screen.
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  final String label;

  static const path = 'details';
  static const name = 'Detail';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Detail $label',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Details for $label',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/a/details/third');
              },
              child: const Text('View third page'),
            ),
          ],
        ),
      ),
    );
  }
}
