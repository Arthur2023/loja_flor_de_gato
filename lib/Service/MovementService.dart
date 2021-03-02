import 'package:flor_de_gato/Models/Movement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MovementService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection("Historic");

  Future<List<Movement>> getAll() async {
    List<Movement> list = [];
    QuerySnapshot snapshot = await collectionReference.get();
    for (final documment in snapshot.docs) {
      list.add(Movement.fromDocumment(documment));
    }
    return list;
  }

  Future<Movement> add(Movement movement) async {
    DocumentReference documentReference = await collectionReference.add(
        movement.toMap());
    movement.id = documentReference.id;
    return movement;
  }

  Future<bool> delete(Movement movement) async {
    try {
      await collectionReference.doc(movement.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

}