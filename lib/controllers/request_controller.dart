import 'package:flor_de_gato/models/month_value.dart';
import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/services/request_service.dart';
import 'package:flutter/cupertino.dart';

class RequestController extends ChangeNotifier {
  RequestController() {
    load();
  }

  Future<void> load() async {
    List<Request> aux = await RequestService().getAll();
    openRequests = aux.where((element) => element.isOpen).toList();
    closedRequests = aux.where((element) => !element.isOpen).toList();

    for (int i = 0; i < 12; i++) {
      MonthValue aux = MonthValue("${i + 1}", 0);
      DateTime firstDay = DateTime(DateTime.now().year, i + 1, 1, 0, 0, 0, 0, 0);
      DateTime firstDayOfNextMonth;
      if (i == 11)
        firstDayOfNextMonth = DateTime(DateTime.now().year+1, 1, 1, 0, 0, 0, 0, 0);
      else
        firstDayOfNextMonth = DateTime(DateTime.now().year, i + 2, 1, 0, 0, 0, 0, 0);


      print('\n\n\n\n ##################################3');
      print(aux);
      print("first day => ${firstDay.toIso8601String()}");
      print("first day of next month=> ${firstDayOfNextMonth.toIso8601String()}");

      for (final request in closedRequests.where((element) => element.dateTime.isAfter(firstDay) && element.dateTime.isBefore(firstDayOfNextMonth))) {
        aux.value += request.price;
      }

      print(aux);
      monthValues.add(aux);
    }

    notifyListeners();
  }

  List<Request> openRequests = [];
  List<Request> closedRequests = [];
  List<MonthValue> monthValues = [];

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
      print(e);
      return false;
    }
  }

  void remove(Request r) {
    openRequests.remove(r);
    notifyListeners();
  }

  void homeChangeEstimatedTime(num value, Request r) {
    r.estimatedTime += value;
    RequestService().update(r);
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
