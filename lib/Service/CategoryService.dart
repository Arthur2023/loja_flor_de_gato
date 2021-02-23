import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Category.dart';

class CategoryService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("Categorys");

  Future<List<Category>> getAll() async {
    List<Category> list = [];
    QuerySnapshot snapshot = await collectionReference.get();
    for(final documment in snapshot.docs){
      list.add(Category.fromDocumment(documment));
    }
    return list;
  }

  Future<Category> add(Category category) async {
    DocumentReference documentReference = await collectionReference.add(category.toMap());
    category.id = documentReference.id;
    return category;
  }

  Future<void> delete(Category category) async {
    await collectionReference.doc(category.id).delete();
  }

}
