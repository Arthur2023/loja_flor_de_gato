import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/category.dart';
import 'package:flor_de_gato/models/movement.dart';
import 'package:flor_de_gato/services/category_service.dart';
import 'package:flor_de_gato/services/movement_service.dart';
import 'package:flor_de_gato/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  static final ProductController _instance = ProductController.internal();

  factory ProductController() => _instance;

  ProductController.internal() {
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

  bool _typemov = true;

  bool get typemov => _typemov;

  set typemov(bool value) {
    _typemov = value;
    notifyListeners();
  }

  List<Product> get actualProducts => _actualProducts;

  set actualProducts(List<Product> value) {
    _actualProducts = value;
    notifyListeners();
  }

  num get tot {
    num tot = 0;
    for (final product in actualProducts) tot += product.price;
    return tot;
  }

  Future<bool> add(Product p, Category c) async {
    if (c.id == null) c = await CategoryService().add(c);
    if (c == null) return false;

    p.categoryID = c.id;
    num movimentQuantity = p.quantity;

    if (p.id == null) {
      p = await ProductService().add(p);
    } else {
      Product aux = actualProducts.firstWhere((element) => element.id == p.id);
      p.price += aux.price;
      p.quantity = aux.quantity + p.quantity;
      p = await ProductService().update(p);
    }
    if (p == null) return false;
    await MovementService().add(Movement.fromProduct(p..quantity = movimentQuantity));
    await load();
    return true;
  }

  Future<bool> remove(Product p) async {
    if (!await ProductService().delete(p)) return false;
    actualProducts.remove(p);
    Category c = findCategory(p.categoryID);
    if (c != null) {
      print("AQUI");
      c.products.removeWhere((element) => element.id == p.id);
    }
    notifyListeners();
    return true;
  }

  Future<bool> addCategory(Category c) async {
    c = await CategoryService().add(c);
    if (c == null) return false;
    categorys.add(c);
    notifyListeners();
    return true;
  }

  Category findCategory(String categoryID) {
    Category c = categorys.firstWhere((element) => element.id == categoryID, orElse: () => null);
    return c;
  }

  Product findProduct(String productID) {
    Product c = _actualProducts.firstWhere((element) => element.id == productID, orElse: () => null);
    return c;
  }
}
