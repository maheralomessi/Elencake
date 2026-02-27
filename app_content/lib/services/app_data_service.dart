import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/business_info.dart';
import '../models/category.dart';
import '../models/product.dart';

class CatalogData {
  final List<Category> categories;
  final List<Product> products;

  const CatalogData({required this.categories, required this.products});
}

class AppDataService {
  const AppDataService();

  Future<CatalogData> loadCatalog() async {
    final raw = await rootBundle.loadString('assets/data/catalog.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final cats = (json['categories'] as List<dynamic>)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
    final prods = (json['products'] as List<dynamic>)
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
    return CatalogData(categories: cats, products: prods);
  }

  Future<BusinessInfo> loadBusinessInfo() async {
    final raw = await rootBundle.loadString('assets/data/business.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return BusinessInfo.fromJson(json);
  }
}
