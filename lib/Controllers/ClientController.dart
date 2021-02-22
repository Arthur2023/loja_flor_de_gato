import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Service/ClientService.dart';
import 'package:flutter/material.dart';


class ClientController extends ChangeNotifier {
  ClientController(){
    ClientService().getAll().then((value) => actualClients = value);
  }
  List<Client> _actualClients = [

  ];


  List<Client> get actualClients => _actualClients;

  set actualClients(List<Client> value) {
    _actualClients = value;
    _actualClients.forEach(print);
    notifyListeners();
  }

  Future<void> add(Client c) async {

    await ClientService().add(c);
    actualClients.add(c);
    notifyListeners();

  }

  Future<void> update(Client c) async {

    await ClientService().update(c);
    if(actualClients.any((element) => element.id == c.id)){
      actualClients.firstWhere((element) => element.id == c.id).desclone(c);
    }
    notifyListeners();

  }

  void remove(Client c){

    actualClients.remove(c);
    notifyListeners();

  }

}