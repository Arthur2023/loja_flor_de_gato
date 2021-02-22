import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Product.dart';

class ProductService {
  Firestore firestore = Firestore.instance;
  CollectionReference collectionReference = Firestore.instance.collection("Inputs");

  Future<List<Product>> getAll() async {
    List<Product> list = [];
    QuerySnapshot snapshot = await collectionReference.getDocuments();
    for(final documment in snapshot.documents){
      list.add(Product.fromDocumment(documment));
    }
    return list;
  }

  Future<Product> add(Product product) async {
    DocumentReference documentReference = await collectionReference.add(product.toMap());
    product.id = documentReference.documentID;
    return product;
  }

  Future<void> delete(Product product) async {
    await collectionReference.document(product.id).delete();
  }
}
