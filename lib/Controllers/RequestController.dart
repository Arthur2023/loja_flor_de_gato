import 'package:flor_de_gato/Models/Request.dart';
import 'package:flutter/cupertino.dart';

class RequestController extends ChangeNotifier{

  List<Request> actualRequests = [

  ];

  void add(Request r){

    actualRequests.add(r);
    notifyListeners();

  }

  void remove(Request r){

    actualRequests.remove(r);
    notifyListeners();

  }

}