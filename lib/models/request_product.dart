import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/models/product.dart';

class RequestProduct {
  String id;
  String productID;
  int quantity;
  num price;

  Product product;

  RequestProduct.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    productID = documentSnapshot["productID"];
    quantity = documentSnapshot["quantity"];
    price = documentSnapshot["price"];
  }

  Map<String, dynamic> toMap() => {
        "productID": productID,
        "quantity": quantity,
        "price": price,
      };

  RequestProduct.fromProduct(Product p) {
    id = null;
    productID = p.id;
    quantity = 0;
    product = p;
    price = 0;
  }
}
