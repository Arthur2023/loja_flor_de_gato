import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/RequestProduct.dart';
import 'package:flor_de_gato/Service/RequestService.dart';
import 'package:flutter/cupertino.dart';

class Request extends ChangeNotifier {
  String id;
  String title;
  String client;
  String estimatedDate;
  num estimatedTime;
  String formOfPayment;
  String description;
  num price;
  num delivery;
  String state = "";

  void changeEstimatedTime(num value) {
    print(value);
    estimatedTime = value;
    notifyListeners();
  }

  num totPrice() {
    print(materialsPrice);
    print(estimatedTime);
    print(delivery);
    return ((materialsPrice ?? 0) + (estimatedTime * 4.5)) * 1.35 + delivery;
  }

  void changeDelivery(num value) {
    delivery = value;
    notifyListeners();
  }

  List<RequestProduct> products = [];

  Request(
    this.title,
    this.client,
    this.estimatedDate,
    this.estimatedTime,
    this.formOfPayment,
    this.price, {
    this.id,
    this.state,
    this.delivery,
    this.description,
    this.products,
  }) {
    if (products == null) products = [];
    if (estimatedTime == null) estimatedTime = 0;
    if (delivery == null) delivery = 0;
  }

  bool get isOpen {
    switch (state) {
      case "open":
      case "awaiting":
        return true;
      default:
        return false;
    }
  }

  Future<void> loadProducts() async {
    products = await RequestService().getProductsFromRequest(id);
    notifyListeners();
  }

  @override
  String toString() {
    return 'Request{id: $id, title: $title, client: $client, estimatedDate: $estimatedDate, estimatedTime: $estimatedTime, formOfPayment: $formOfPayment, description: $description, price: $price, delivery: $delivery, state: $state, products: $products}';
  }

  Request.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    title = documentSnapshot.data()["title"];
    client = documentSnapshot.data()["client"];
    estimatedDate = documentSnapshot.data()["estimatedDate"];
    estimatedTime = documentSnapshot.data()["estimatedTime"];
    formOfPayment = documentSnapshot.data()["formOfPayment"];
    description = documentSnapshot.data()["description"];
    price = documentSnapshot.data()["price"];
    delivery = documentSnapshot.data()["delivery"];
    state = documentSnapshot.data()["state"];
    loadProducts();
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "client": client,
      "estimatedDate": estimatedDate,
      "estimatedTime": estimatedTime,
      "formOfPayment": formOfPayment,
      "description": description,
      "price": price,
      "delivery": delivery,
      "state": state,
    };
  }

  Request clone() {
    return Request(
      this.title,
      this.client,
      this.estimatedDate,
      this.estimatedTime,
      this.formOfPayment,
      this.price,
      id: this.id,
      state: this.state,
      delivery: this.delivery,
      description: this.description,
      products: products,
    );
  }

  num get materialsPrice {
    num totRequest = 0;
    for (final p in products) totRequest += p.product.price;
    return totRequest;
  }

  void desclone(Request request) {
    id = request.id;
    title = request.title;
    client = request.client;
    estimatedDate = request.estimatedDate;
    estimatedTime = request.estimatedTime;
    formOfPayment = request.formOfPayment;
    price = request.price;
    description = request.description;
    delivery = request.delivery;
    products = request.products;
    state = request.state;
  }

  void addRequestProduct(RequestProduct p) {
    products.add(p);
    notifyListeners();
  }

  void removeRequestProduct(RequestProduct p) {
    products.remove(p);
    notifyListeners();
  }

  void closeRequest(Request r) async {
    r.state = "closed";
    notifyListeners();
  }

  int getAvaliableQuantityFromProductAtMoment(Product p) {
    int aux = p.quantity;
    print(aux);
    for (final rp in products) {
      if (rp.product.id == p.id && rp.id == null) {
        aux -= rp.quantity;
      }
    }
    print(aux);
    return aux;
  }
}
