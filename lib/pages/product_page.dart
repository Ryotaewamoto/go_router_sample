import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/exceptions/base.dart';
import '../utils/routing/app_routes.dart';
import 'products_list_page.dart';
import 'third_screen.dart';

/// productId を取得してから返す Provider。
final productIdProvider = Provider.autoDispose<String>(
  (ref) {
    try {
      final state = ref.read(goRouterStateProvider);
      final productId = state.params['productId']!;
      return productId;
    } on Exception {
      throw const AppException(message: 'ルームが見つかりませんでした。');
    }
  },
  dependencies: <Provider>[
    goRouterStateProvider,
  ],
);

/// The details screen for either the A or B screen.
class ProductPage extends HookConsumerWidget {
  /// Constructs a [ProductPage].
  const ProductPage({
    Key? key,
  }) : super(key: key);

  static const path = '/products-list/:productId';
  static const name = 'Product';
  static String location({required String productId}) =>
      '/products-list/$productId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => GoRouter.of(context).go(ProductsListPage.location),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Product',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              ref.watch(productIdProvider) ?? 'no data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(
                    '${ProductsListPage.location}/${ProductPage.location}/${ThirdScreen.location}');
              },
              child: const Text('View third page'),
            ),
          ],
        ),
      ),
    );
  }
}
