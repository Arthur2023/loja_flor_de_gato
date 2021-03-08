import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Client extends ChangeNotifier{
  String id;
  String name;
  String phone;
  String email;
  String address;
  String cpf;
  String image;

  File file;

  @override
  String toString() {
    return 'Client{id: $id, name: $name, phone: $phone, email: $email, address: $address, cpf: $cpf, image: $image}';
  }

  void changeImage(File img){
    file = img;
    notifyListeners();
  }

  Client(this.name, this.phone,
      {this.email = "", this.address = "", this.cpf = "", this.id, this.image});

  Client.fromDocumment(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    name = documentSnapshot.data()["name"];
    email = documentSnapshot.data()["email"];
    phone = documentSnapshot.data()["phone"];
    address = documentSnapshot.data()["address"];
    cpf = documentSnapshot.data()["cpf"];
    image = documentSnapshot.data()["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "cpf": cpf,
      "image": image,
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
      image: this.image
    );
  }

  void desclone(Client client){
    id = client.id;
    name = client.name;
    phone = client.phone;
    email = client.email;
    address = client.address;
    cpf = client.cpf;
    image = client.image;

  }

}
