import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Service/MovementService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovementController extends ChangeNotifier {
  MovementController() {
    MovementService().getAll().then((value) => movements = value);
  }

  Future<void> load() async {
    movements = await MovementService().getAll();
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