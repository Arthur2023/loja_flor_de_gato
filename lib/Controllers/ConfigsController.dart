import 'package:flor_de_gato/Models/Configs.dart';
import 'package:flor_de_gato/Service/ConfigsService.dart';
import 'package:flutter/cupertino.dart';

class ConfigsController extends ChangeNotifier {
  ConfigsController() {
    load();
  }

  Configs configs;

  Future<void> load() async {
    configs = Configs();
    ConfigsService().get((snapshot) {
      print("NEWLISTEN");
      for (final documentSnapshot in snapshot.docs) {
        configs.priceHour = documentSnapshot.data()["pricehour"];
        configs.margin = documentSnapshot.data()["margin"];
        int c = int.parse(documentSnapshot.data()["color"]);
        configs.color = Color(c);
        notifyListeners();
      }
    });
  }

  Future<bool> update () async {
  try {
  if (await ConfigsService().update(configs))
    print('CERTO');
      notifyListeners();
  return true;
} catch(e){
    print(e);
  return false;}
  }

}
