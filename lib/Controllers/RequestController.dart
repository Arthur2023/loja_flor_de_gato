import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flutter/cupertino.dart';

class RequestController extends ChangeNotifier {
  RequestController() {
    print(requestProducts.length);
  }

  num _estimatedTime = 0;
  num _delivery = 0;

  num get delivery => _delivery;

  set delivery(num value) {
    _delivery = value;
    print("$_delivery");
    notifyListeners();
  }

  num get estimatedTime => _estimatedTime;

  set estimatedTime(num value) {
    _estimatedTime = value;
    print("$_estimatedTime");
    notifyListeners();
  }

  List<Request> actualRequests = [];

  List<Product> requestProducts = [];

  Future<bool> add(Request r) async {
    try {
      actualRequests.add(r);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void remove(Request r) {
    actualRequests.remove(r);
    notifyListeners();
  }

  void addProduct(Product p) {
    requestProducts.add(p);
    notifyListeners();
  }
  void removeProduct(Product p) {
    requestProducts.remove(p);
    notifyListeners();
  }

  num get materialsPrice {
    num totRequest = 0;
    for (final product in requestProducts) totRequest += product.price;
    return totRequest;
  }

  num get totPrice {
    return (materialsPrice + _estimatedTime * 4.5) * 1.35 + delivery ;
  }
}
