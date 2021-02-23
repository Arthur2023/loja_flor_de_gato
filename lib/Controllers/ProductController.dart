import 'package:flor_de_gato/Models/Category.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Service/CategoryService.dart';
import 'package:flor_de_gato/Service/ProductService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  ProductController() {
    load();
  }

  Future<void> load() async {
    _actualProducts = await ProductService().getAll();
    _categorys = await CategoryService().getAll();
    Category others = Category("Others");
    for (final product in _actualProducts) {
      if (_categorys.any((element) => element.id == product.categoryID)) {
        _categorys.firstWhere((element) => element.id == product.categoryID).products.add(product);
      } else {
        others.products.add(product);
      }
    }
    _categorys.add(others);
    notifyListeners();
  }

  List<Product> _actualProducts = [];
  List<Category> _categorys = [];

  List<Category> get categorys => _categorys;

  set categorys(List<Category> value) {
    _categorys = value;
    notifyListeners();
  }

  List<Product> get actualProducts => _actualProducts;

  set actualProducts(List<Product> value) {
    _actualProducts = value;
    notifyListeners();
  }

  void add(Product p) {
    actualProducts.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    actualProducts.remove(p);
    notifyListeners();
  }

  Future<bool> addCategory(Category c) async {
    c = await CategoryService().add(c);
    if (c == null) return false;
    categorys.add(c);
    notifyListeners();
    return true;
  }
}
