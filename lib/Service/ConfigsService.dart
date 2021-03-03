import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Configs.dart';

class ConfigsService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection("Configs");

  Future<void> get(Function onListen) async {
    collectionReference.snapshots().listen(onListen);
  }

  Future<bool> update (Configs configs) async {
    try{
      await collectionReference.doc("Price").update(configs.toMap());
      print('CERTO');
      return true;
    } catch (e){
      print(e);
      return false;
    }
  }
}