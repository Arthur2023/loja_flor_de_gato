import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Client.dart';

class ClientService {
  Firestore firestore = Firestore.instance;
  CollectionReference collectionReference = Firestore.instance.collection("Clients");

  Future<List<Client>> getAll() async {
    List<Client> list = [];
    QuerySnapshot snapshot = await collectionReference.getDocuments();
    for(final documment in snapshot.documents){
      list.add(Client.fromDocumment(documment));
    }
    return list;
  }

  Future<Client> add(Client client) async {
    DocumentReference documentReference = await collectionReference.add(client.toMap());
    client.id = documentReference.documentID;
    return client;
  }

  Future<void> update(Client client) async {
    await collectionReference.document(client.id).updateData(client.toMap());
  }

  Future<void> delete(Client client) async {
    await collectionReference.document(client.id).delete();
  }
}
