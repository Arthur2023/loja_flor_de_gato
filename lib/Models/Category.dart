import 'package:cloud_firestore/cloud_firestore.dart';
import 'Product.dart';


class Category {
  String id;
  String name;


  List<Product> products = [];

  Category(this.name);


  @override
  String toString() {
    return 'Category{id: $id, name: $name, products: $products}';
  }

  Category.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }

  void desclone(Category category) {
    if(category == null) return;
    id = category.id;
    name = category.name;
  }
}