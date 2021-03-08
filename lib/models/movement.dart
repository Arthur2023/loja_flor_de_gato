import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/models/product.dart';

class Movement {
  String id;
  Timestamp date;
  String productID;
  num quantity;
  num price;
  String shopping;

  Product product;

  Map<String, dynamic> toMap() {
    return {
      "date": Timestamp.now(),
      "productID": productID,
      "quantity": quantity,
      "price": price,
      "shopping": shopping
    };
  }

  Movement.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    date = documentSnapshot.data()["date"];
    productID = documentSnapshot.data()["productID"];
    quantity = documentSnapshot.data()["quantity"];
    price = documentSnapshot.data()["price"];
    shopping = documentSnapshot.data()["shopping"];
  }

  Movement.fromProduct(Product product) {
    productID = product.id;
    quantity = product.quantity;
    price = product.price;
    shopping = product.shopping;
  }

}
