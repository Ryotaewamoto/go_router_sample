import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_sample/utils/constants/products_sample_list.dart';

import 'product_page.dart';

class ProductsListPage extends StatelessWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  static const path = '/products-list';
  static const name = 'ProductsList';
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
          'Products',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: productsSampleList.length,
        itemBuilder: (context, index) {
          final product = productsSampleList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                GoRouter.of(context).go(
                  ProductPage.location(
                    productId: product.productId,
                  ),

                );
              },
              child: product.faIcon,
            ),
          );
        },
        shrinkWrap: true,
      ),
      // Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       const Text('Screen A'),
      //       TextButton(
      //         onPressed: () {
      //           GoRouter.of(context).go(
      //               '${ProductsListPage.location}/${ProductPage.location}s');
      //         },
      //         child: const Text('View A details'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
