import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';
import '../models/product.dart';
import 'catalog_provider.dart';

class CartProvider extends ChangeNotifier {
  static const _prefsKey = 'eileen_cart_v1';

  final Map<int, int> _qtyByProductId = {};

  List<CartItem> items(CatalogProvider catalog) {
    final result = <CartItem>[];
    for (final entry in _qtyByProductId.entries) {
      final product = catalog.productById(entry.key);
      if (product == null) continue;
      result.add(CartItem(product: product, quantity: entry.value));
    }
    return result;
  }

  int quantityFor(int productId) => _qtyByProductId[productId] ?? 0;

  int get totalItems => _qtyByProductId.values.fold(0, (a, b) => a + b);

  double totalPrice(CatalogProvider catalog) {
    double total = 0;
    for (final it in items(catalog)) {
      total += it.total;
    }
    return total;
  }

  void add(Product product, {int amount = 1}) {
    final current = _qtyByProductId[product.id] ?? 0;
    _qtyByProductId[product.id] = (current + amount).clamp(0, 999);
    notifyListeners();
    _save();
  }

  void setQuantity(Product product, int qty) {
    if (qty <= 0) {
      _qtyByProductId.remove(product.id);
    } else {
      _qtyByProductId[product.id] = qty.clamp(1, 999);
    }
    notifyListeners();
    _save();
  }

  void remove(Product product) {
    _qtyByProductId.remove(product.id);
    notifyListeners();
    _save();
  }

  void clear() {
    _qtyByProductId.clear();
    notifyListeners();
    _save();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return;

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      _qtyByProductId.clear();
      for (final it in decoded) {
        final m = (it as Map).cast<String, dynamic>();
        final id = (m['id'] as num).toInt();
        final qty = (m['qty'] as num).toInt();
        if (qty > 0) _qtyByProductId[id] = qty;
      }
      notifyListeners();
    } catch (_) {
      // ignore malformed
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final list = _qtyByProductId.entries
        .map((e) => {'id': e.key, 'qty': e.value})
        .toList();
    await prefs.setString(_prefsKey, jsonEncode(list));
  }
}
