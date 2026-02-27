import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/catalog_provider.dart';
import 'screens/home/cart_screen.dart';
import 'screens/home/categories_screen.dart';
import 'screens/home/info_screen.dart';
import 'screens/main_shell.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final catalog = CatalogProvider();
  final cart = CartProvider();

  await catalog.load();
  await cart.loadFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: catalog),
        ChangeNotifierProvider.value(value: cart),
      ],
      child: const EileenCakeApp(),
    ),
  );
}

class EileenCakeApp extends StatelessWidget {
  const EileenCakeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eileen Cake',
      theme: AppTheme.light(),
      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      routes: {
        '/': (_) => const SplashScreen(),
        '/main': (_) => const MainShell(),
        '/categories': (_) => const CategoriesScreen(),
        '/cart': (_) => const CartScreen(),
        '/info': (_) => const InfoScreen(),
      },
    );
  }
}
