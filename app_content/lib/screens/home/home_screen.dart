import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../providers/catalog_provider.dart';
import '../../screens/product/product_details_screen.dart';
import '../../screens/product/product_list_screen.dart';
import '../../utils/format.dart';
import '../../widgets/brand_logo.dart';
import '../../widgets/category_card.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final cart = context.watch<CartProvider>();
    final business = catalog.business;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              const BrandLogo(height: 40),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.nameArabic,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      business.slogan,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black54),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                  if (cart.totalItems > 0)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          cart.totalItems.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Search
          TextField(
            onChanged: (v) => catalog.setSearch(v),
            decoration: InputDecoration(
              hintText: 'ابحث عن منتج…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: catalog.search.trim().isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => catalog.setSearch(''),
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          const SizedBox(height: 14),

          // Hero
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'حلويات صنعت لسعادتكم 🍰',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'تصفح الأقسام واطلب عبر واتساب بسرعة.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/categories'),
                              icon: const Icon(Icons.grid_view_rounded),
                              label: const Text('الأقسام'),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/info'),
                              icon: const Icon(Icons.phone_in_talk_outlined),
                              label: Text(business.phoneDisplay),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/products/cupcake_promo.jpg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          
          const SizedBox(height: 18),

          // Categories
          Row(
            children: [
              Expanded(
                child: Text('الأقسام',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/categories'),
                child: const Text('عرض الكل'),
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: catalog.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final c = catalog.categories[i];
                return SizedBox(
                  width: 220,
                  child: CategoryCard(
                    category: c,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(
                            title: c.name,
                            categoryId: c.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),

          // Featured
          Row(
            children: [
              Expanded(
                child: Text('منتجات مميزة',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              if (catalog.search.trim().isNotEmpty)
                Text(
                  'نتائج: ${catalog.filteredProducts.length}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black54),
                ),
            ],
          ),
          const SizedBox(height: 10),

          Builder(
            builder: (_) {
              final list = catalog.search.trim().isNotEmpty
                  ? catalog.filteredProducts
                  : catalog.featuredProducts;

              if (list.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Center(child: Text('لا توجد منتجات مطابقة للبحث.')),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: list.length.clamp(0, 10),
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
              );
            },
          ),

          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping_outlined),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'الأسعار قابلة للتعديل حسب الطلب والمناسبات. للتأكيد النهائي تواصل عبر واتساب.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
