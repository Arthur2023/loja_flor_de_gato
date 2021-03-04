import 'package:flor_de_gato/Models/Configs.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Tabs/ClientTab.dart';
import 'package:flor_de_gato/Tabs/HistoricTab.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/Tabs/Home/HomeTab.dart';
import 'package:flor_de_gato/Tabs/InventoryTab.dart';
import 'package:flor_de_gato/Tabs/RequestTab.dart';
import 'package:flor_de_gato/Tabs/SettingsTab.dart';

import 'package:flutter/material.dart';

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
