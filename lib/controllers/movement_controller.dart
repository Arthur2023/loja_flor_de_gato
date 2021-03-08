import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/models/movement.dart';
import 'package:flor_de_gato/Service/movement_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovementController extends ChangeNotifier {
  MovementController() {
    load();
  }

  bool _isLoading = false;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    movements = await MovementService().getAll();
    isLoading = false;
    notifyListeners();
  }

  List<Movement> movements = [];

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateformat = timestamp.toDate();
    final format = DateFormat("dd/MM/yyyy");
    var dd =(format.format(dateformat));
    String date = dd;
    return date;
  }

}