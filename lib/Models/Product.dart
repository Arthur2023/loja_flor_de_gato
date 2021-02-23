import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String mark;
  String color;
  String categoryID;
  num quantity;
  num price;
  String shopping;

  Product(this.name, this.mark, this.color, this.quantity, this.price, this.shopping);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, mark: $mark, color: $color, shopping:$shopping}';
  }

  Product.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
    mark = documentSnapshot.data()["mark"];
    color = documentSnapshot.data()["color"];
    quantity = documentSnapshot.data()["quantity"];
    price = documentSnapshot.data()["price"];
    categoryID = documentSnapshot.data()["categoryID"];
    shopping = documentSnapshot.data()["shopping"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "mark": mark,
      "color": color,
      "quantity": quantity,
      "price": price,
      "categoryID": categoryID,
      "shopping":shopping,
    };
  }

}