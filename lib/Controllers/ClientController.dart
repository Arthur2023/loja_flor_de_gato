import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Service/ClientService.dart';
import 'package:flutter/material.dart';

class ClientController extends ChangeNotifier {
  ClientController() {
    ClientService().getAll().then((value) => actualClients = value);
  }

  List<Client> _actualClients = [];

  List<Client> get actualClients => _actualClients;

  set actualClients(List<Client> value) {
    _actualClients = value;
    _actualClients.forEach(print);
    notifyListeners();
  }

  Future<bool> add(Client c) async {
    c = await ClientService().add(c);
    if (c == null) return false;
    actualClients.add(c);
    notifyListeners();
    return true;
  }

  Future<bool> update(Client c) async {
    try {
      await ClientService().update(c);
    } catch (e) {
      return false;
    }
    if (actualClients.any((element) => element.id == c.id)) {
      actualClients.firstWhere((element) => element.id == c.id).desclone(c);
    }
    notifyListeners();
    return true;
  }

  Future<bool> remove(Client c) async {
   try{
     await ClientService().delete(c);
     actualClients.remove(c);
     if (actualClients.any((element) => element.id == c.id)) {
       actualClients.removeWhere((element) => element.id == c.id);
       notifyListeners();
       return true;
   }
    } catch(e){
     return false;
   }
  }

  Client findID(String id){
    return _actualClients.firstWhere((element) => element.id == id, orElse:() => Client("Client not found",""));
  }

}
