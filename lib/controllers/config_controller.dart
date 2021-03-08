import 'package:flor_de_gato/models/configs.dart';
import 'package:flor_de_gato/Service/config_service.dart';
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
