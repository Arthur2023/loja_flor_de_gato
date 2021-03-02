import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Service/ProductService.dart';

class Product {
  String id;
  String name;
  String mark;
  String color;
  String categoryID;
  num quantity;
  num price;
  String shopping;

  bool isNewFromRequest = false;

  Product(this.name, this.mark, this.color, this.quantity, this.price, this.shopping, {this.id, this.categoryID}){
    if(quantity == null) quantity = 0;
  }


  @override
  String toString() {
    return 'Product{id: $id, name: $name, mark: $mark, color: $color, categoryID: $categoryID, quantity: $quantity, price: $price, shopping: $shopping}';
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

  Map<String, dynamic> toMap({bool local= false}) {
    return {
      "name": name,
      "mark": mark,
      "color": color,
      "quantity": quantity,
      "price": price,
      "categoryID": categoryID,
      "shopping": shopping,
    };
  }

  void desclone(Product product) {
    if (product == null) return;
    id = product.id;
    name = product.name;
    mark = product.mark;
    color = product.color;
    quantity = product.quantity;
    price = product.price;
    categoryID = product.categoryID;
    shopping = product.shopping;
  }

  Product clone() {
    return Product(name, mark, color, quantity, price, shopping, categoryID: categoryID, id: id);
  }

  Future<void> updateQuantity() async {
    await ProductService().update(this);

  }
}
