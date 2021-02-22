import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String mark;
  String color;
  String quantity;
  String price;

  Product(this.name, this.mark, this.color);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, mark: $mark, color: $color}';
  }

  Product.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    name = documentSnapshot.data["name"];
    mark = documentSnapshot.data["mark"];
    color = documentSnapshot.data["color"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "mark": mark,
      "color": color,
    };
  }

}