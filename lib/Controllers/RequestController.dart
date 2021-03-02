import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Service/RequestService.dart';
import 'package:flutter/cupertino.dart';

class RequestController extends ChangeNotifier {
  RequestController() {
    load();
  }

  Future<void> load() async {
    List<Request> aux = await RequestService().getAll();
    openRequests = aux.where((element) => element.isOpen).toList();
    closedRequests = aux.where((element) => !element.isOpen).toList();
    notifyListeners();
  }

  List<Request> openRequests = [];
  List<Request> closedRequests = [];

  Future<bool> save(Request r) async {
    try {

      r.state = "open";

      r = await RequestService().add(r);
      if (r == null) throw Exception();
      if (!await RequestService().addProducts(r)) throw Exception();
      openRequests.add(r);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  void remove(Request r) {
    openRequests.remove(r);
    notifyListeners();
  }

  Future<bool> update(Request r) async {
    try {
      if (!await RequestService().update(r)) throw Exception();
      print('UPDATE R');
      if (!await RequestService().addProducts(r)) throw Exception("ERRO ADD PRODUCTS");
      print('ADDPRODUTS');
      openRequests.firstWhere((element) => element.id == r.id).desclone(r);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> closeRequest(Request r) async {
    try {
      r.state = "closed";
      if (!await RequestService().update(r)) throw Exception();
      openRequests.removeWhere((element) => element.id == r.id);
      closedRequests.add(r);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancelRequest(Request r) async {
    try {
      if (!await RequestService().cancelRequest(r)) throw Exception();
      await load();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
