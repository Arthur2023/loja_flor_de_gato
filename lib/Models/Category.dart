import 'package:cloud_firestore/cloud_firestore.dart';
import 'Product.dart';


class Category {
  String id;
  String name;


  List<Product> products = [];

  Category(this.name);

  @override
  String toString() {
    return 'Product{id: $id, name: $name}';
  }

  Category.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
    };
  }
}