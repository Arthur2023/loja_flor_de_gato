import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Models/RequestProduct.dart';

class RequestService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Requests");

  Future<List<Request>> getAll() async {
    List<Request> list = [];
    QuerySnapshot snapshot = await collectionReference.get();
    for (final documment in snapshot.docs) {
      list.add(Request.fromDocumment(documment));
    }
    return list;
  }

  Future<List<RequestProduct>> getProductsFromRequest(String id) async {
    List<RequestProduct> list = [];
    QuerySnapshot snapshot = await collectionReference.doc(id).collection("Products").get();
    for (final documment in snapshot.docs) {
      RequestProduct r = RequestProduct.fromDocumment(documment);
      r.product = ProductController().findProduct(r.productID);
      list.add(r);
    }
    return list;
  }

  Future<Request> add(Request request) async {
    DocumentReference documentReference = await collectionReference.add(request.toMap());
    request.id = documentReference.id;
    return request;
  }

  Future<bool> addProducts(Request r) async {
    CollectionReference productsReference = collectionReference.doc(r.id).collection("Products");
    for (final RequestProduct p in r.products) {
      // if(p.id != null) continue;
      try {
        p.product.quantity -= p.quantity;
        print(p.toString());
        print(p.toMap());
        await p.product.updateQuantity();
        print('DECREMENT OK');
        p.id = (await productsReference.add(p.toMap())).id;
        print('ADDPRODUCT');
      } catch (e) {
        //TODO: Excluir produtos ja adicionados - fazer transacao
        print(e);
        return false;
      }
    }
    return true;
  }

  Future<bool> updateProducts(Request r) async {
    await addProducts(r);
    for (final RequestProduct p in r.products.where((element) => element.id != null).toList()) {
      try {
        DocumentReference productReference = collectionReference.doc(r.id).collection("Products").doc(p.id);
        //TODO: atualizar a diferenca entre estoque e uso de produto;
        await productReference.update(p.toMap());
      } catch (e) {
        //TODO: Excluir produtos ja adicionados - fazer transacao
        return false;
      }
    }
    return true;
  }

  Future<bool> update(Request request, {bool updatedProducts = true}) async {
    print(request);
    try {
      await collectionReference.doc(request.id).update(request.toMap());
      if (updatedProducts) await updateProducts(request);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
