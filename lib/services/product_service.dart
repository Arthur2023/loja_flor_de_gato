import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/models/product.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("Inputs");

  Future<List<Product>> getAll() async {
    List<Product> list = [];
    QuerySnapshot snapshot = await collectionReference.get();
    for (final documment in snapshot.docs) {
      list.add(Product.fromDocumment(documment));
    }
    return list;
  }

  Future<Product> add(Product product) async {
    DocumentReference documentReference = await collectionReference.add(
        product.toMap());
    product.id = documentReference.id;
    return product;
  }

  Future<Product> update(Product product) async {
    try{
      await collectionReference.doc(product.id).update(product.toMap());
    } catch (e){
      product = await add(product);
    }
    return product;
  }

  Future<bool> delete(Product product) async {
    try {
      await collectionReference.doc(product.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


}
