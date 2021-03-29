import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/ui/client/client_screen.dart';
import 'package:flor_de_gato/ui/historic/historic_screen.dart';
import 'package:flor_de_gato/ui/home/home_screen.dart';
import 'package:flor_de_gato/ui/inventory/inventory_screen.dart';
import 'package:flor_de_gato/ui/request/request_screen.dart';
import 'package:flor_de_gato/ui/settings/setting_screen.dart';
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
