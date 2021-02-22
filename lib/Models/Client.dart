import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String id;
  String name;
  String phone;
  String email;
  String address;
  String cpf;

  @override
  String toString() {
    return 'Client{id: $id, name: $name, phone: $phone, email: $email, address: $address, cpf: $cpf}';
  }

  Client(this.name, this.phone,
      {this.email = "", this.address = "", this.cpf = "", this.id});

  Client.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.documentID;
    name = documentSnapshot.data["name"];
    email = documentSnapshot.data["email"];
    phone = documentSnapshot.data["phone"];
    address = documentSnapshot.data["address"];
    cpf = documentSnapshot.data["cpf"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "cpf": cpf,
    };
  }

  Client clone() {
    return Client(
      this.name,
      this.phone,
      email: this.email,
      address: this.address,
      cpf: this.cpf,
      id: this.id,
    );
  }

  void desclone(Client client){
    id = client.id;
    name = client.name;
    phone = client.phone;
    email = client.email;
    address = client.address;
    cpf = client.cpf;
  }
}
