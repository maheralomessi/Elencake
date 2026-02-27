import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catalog_provider.dart';
import '../services/whatsapp_service.dart';
import '../widgets/whatsapp_fab.dart';
import 'home/cart_screen.dart';
import 'home/categories_screen.dart';
import 'home/home_screen.dart';
import 'home/info_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final business = context.watch<CatalogProvider>().business;
    final wa = WhatsAppService(phoneInternational: business.whatsapp);

    final pages = const [
      HomeScreen(),
      CategoriesScreen(),
      CartScreen(),
      InfoScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      floatingActionButton: WhatsAppFab(
        service: wa,
        message: 'السلام عليكم، أريد الاستفسار عن المنتجات والطلبات.',
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (v) => setState(() => _index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
          NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'الأقسام'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), label: 'السلة'),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'معلومات'),
        ],
      ),
    );
  }
}
