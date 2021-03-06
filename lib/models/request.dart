import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/request_product.dart';
import 'package:flor_de_gato/services/product_service.dart';
import 'package:flor_de_gato/services/request_service.dart';
import 'package:flutter/material.dart';

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


  DateTime get dateTime {
    List<String> m = estimatedDate.split("/");

    return DateTime(
      int.parse(m[2]),
      int.parse(m[1]),
      int.parse(m[0]),
    );
  }

  void changeEstimatedTime(num value) {
    estimatedTime = value;
    notifyListeners();
  }

  void changeDelivery(num value) {
    delivery = value;
    notifyListeners();
  }

  num totPrice(num priceHour, num margin) {
    if (isOpen) {
      return ((materialsPrice ?? 0) + (estimatedTime * priceHour)) * (1 + (margin / 100)) + delivery;
    } else {
      return price;
    }
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
    switch (state?? "") {
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
    for (final p in products) totRequest += p.price;
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

  Future<void> removeRequestProduct(RequestProduct p) async {
    p.product.quantity += p.quantity;
    await ProductService().update(p.product);
    products.remove(p);
    notifyListeners();
  }

  void closeRequest(Request r) async {
    r.state = "closed";
    notifyListeners();
  }

  int getAvaliableQuantityFromProductAtMoment(Product p) {
    int aux = p.quantity;
    for (final rp in products) {
      if (rp.product.id == p.id && rp.id == null) {
        aux -= rp.quantity;
      }
    }
    print(aux);
    return aux;
  }

}
