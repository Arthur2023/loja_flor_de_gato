import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/request.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/client/client_screen.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/historic/historic_screen.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/inventory/inventory_screen.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/request/request_screen.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/Settings/setting_screen.dart';
import 'package:flutter/material.dart';

import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/Tabs/Home/home_screen.dart';

class HomePage extends StatelessWidget {

  final pageController = PageController();
  final Request request;
  final Product product;
  HomePage({Key key, this.request, this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
       HomeTab(pageController),
        RequestTab(pageController),
        ClientTab(pageController),
        InventoryTab(pageController),
        HistoricTab(pageController),
        SettingsTab(pageController),
      ],
    );
  }
}
