
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Service/MovementService.dart';
import 'package:flutter/material.dart';

class MovementController extends ChangeNotifier {
  MovementController() {
    MovementService().getAll().then((value) => movements = value);
  }

  Future<void> load() async {
    movements = await MovementService().getAll();
    notifyListeners();
  }

  List<Movement> movements = [];

}