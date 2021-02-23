import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:uuid/uuid.dart';

class ClientService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Clients");

  Future<List<Client>> getAll() async {
    List<Client> list = [];
    QuerySnapshot snapshot = await collectionReference.get();
    for (final documment in snapshot.docs) {
      list.add(Client.fromDocumment(documment));
    }
    return list;
  }

  Future<Client> add(Client client) async {
    try {
        await saveFile(client);
        DocumentReference documentReference =
            await collectionReference.add(client.toMap());
        client.id = documentReference.id;
        return client;

    } catch (e) {
      return null;
    }
  }

  Future<bool> update(Client client) async {
    try {
      await saveFile(client);
      await collectionReference.doc(client.id).update(client.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(Client client) async {
    try {
      await collectionReference.doc(client.id).delete();
      print(
          "\n\n\n ################################################## delete file \n\n\n\n");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveFile(Client client) async {
    print(
        "\n\n\n ################################################## save file \n\n\n\n");
    if (client.file == null) return;
    final UploadTask task =
        FirebaseStorage.instance.ref(Uuid().v1()).putFile(client.file);
    final TaskSnapshot snapshot = await task.whenComplete(() => null);
    final String url = await snapshot.ref.getDownloadURL();
    client.image = url;
  }
}
