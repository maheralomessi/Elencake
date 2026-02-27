import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../widgets/product_card.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final String? categoryId;

  const ProductListScreen({
    super.key,
    required this.title,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final cart = context.watch<CartProvider>();

    final list = catalog.products
        .where((p) => categoryId == null || p.categoryId == categoryId)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: list.length,
          itemBuilder: (context, i) {
            final p = list[i];
            return ProductCard(
              product: p,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsScreen(productId: p.id),
                  ),
                );
              },
              onAdd: () => cart.add(p),
            );
          },
        ),
      ),
    );
  }
}
