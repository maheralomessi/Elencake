import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../services/whatsapp_service.dart';
import '../../utils/format.dart';
import '../../widgets/quantity_stepper.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final cart = context.watch<CartProvider>();
    final product = catalog.productById(productId);

    if (product == null) {
      return const Scaffold(
        body: Center(child: Text('المنتج غير موجود.')),
      );
    }

    final qty = cart.quantityFor(product.id);
    final wa = WhatsAppService(phoneInternational: catalog.business.whatsapp);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/products/placeholder.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  Format.price(product.price),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  product.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54, height: 1.6),
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    QuantityStepper(
                      value: qty == 0 ? 1 : qty,
                      onMinus: () {
                        final current = qty == 0 ? 1 : qty;
                        final next = (current - 1).clamp(1, 999);
                        cart.setQuantity(product, next);
                      },
                      onPlus: () {
                        final current = qty == 0 ? 1 : qty;
                        cart.setQuantity(product, current + 1);
                      },
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          final current = qty == 0 ? 1 : qty;
                          cart.setQuantity(product, current);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تمت الإضافة إلى السلة')), 
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart_outlined),
                        label: const Text('إضافة للسلة'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    final msg = 'السلام عليكم، أريد طلب: ${product.name}\nالسعر: ${Format.price(product.price)}';
                    wa.openChat(message: msg);
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('اطلب مباشرة عبر واتساب'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            onPressed: () => Navigator.of(context).pushNamed('/cart'),
            child: const Text('الذهاب إلى السلة'),
          ),
        ),
      ),
    );
  }
}
