import 'package:cloud_firestore/cloud_firestore.dart';

import 'Product.dart';

class Movement {

  String id;
  String date;
  String productID;
  num quantity;

  Product product;

  Map<String, dynamic> toMap() {
    return {
      "date": Timestamp.now().toString(),
      "productID": productID,
      "quantity": quantity
    };
  }

  Movement.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    date = documentSnapshot.data()["date"].toString();
    productID = documentSnapshot.data()["productID"];
    quantity = documentSnapshot.data()["quantity"];

  }

  Movement.fromProduct(Product product){
    productID = product.id;
    quantity = product.quantity;
  }

}