import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/RequestProduct.dart';

class ProductService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<RequestProduct> add(String id, RequestProduct requestProduct) async {
    CollectionReference productsReference = FirebaseFirestore.instance.collection("Requests").doc(id).collection("Products");
    DocumentReference documentReference = await productsReference.add(
        requestProduct.toMap());
    requestProduct.id = documentReference.id;
    return requestProduct;
  }


  Future<bool> delete(String id, RequestProduct requestProduct) async {
    CollectionReference productsReference = FirebaseFirestore.instance.collection("Requests").doc(id).collection("Products");
    try {
      await productsReference.doc(requestProduct.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }


}
