import 'package:flutter/material.dart' hide Category;

import '../models/business_info.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/app_data_service.dart';

class CatalogProvider extends ChangeNotifier {
  final AppDataService _service;

  CatalogProvider({AppDataService? service}) : _service = service ?? const AppDataService();

  BusinessInfo? _business;
  List<Category> _categories = const [];
  List<Product> _products = const [];

  String _search = '';
  String? _activeCategoryId;

  BusinessInfo get business => _business!;
  List<Category> get categories => _categories;
  List<Product> get products => _products;

  String get search => _search;
  String? get activeCategoryId => _activeCategoryId;

  bool get isReady => _business != null && _categories.isNotEmpty;

  Future<void> load() async {
    final b = await _service.loadBusinessInfo();
    final catalog = await _service.loadCatalog();
    _business = b;
    _categories = catalog.categories;
    _products = catalog.products;
    notifyListeners();
  }

  void setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void setActiveCategory(String? categoryId) {
    _activeCategoryId = categoryId;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    Iterable<Product> result = _products;

    if (_activeCategoryId != null && _activeCategoryId!.isNotEmpty) {
      result = result.where((p) => p.categoryId == _activeCategoryId);
    }

    final q = _search.trim();
    if (q.isNotEmpty) {
      result = result.where(
        (p) => p.name.contains(q) || p.description.contains(q),
      );
    }

    return result.toList();
  }

  List<Product> get featuredProducts => _products.where((p) => p.featured).toList();

  Category? categoryById(String id) {
    for (final c in _categories) {
      if (c.id == id) return c;
    }
    return null;
  }

  Product? productById(int id) {
    for (final p in _products) {
      if (p.id == id) return p;
    }
    return null;
  }
}
