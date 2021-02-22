import 'package:flor_de_gato/Models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {

  List<Product> actualProducts = [

  ];

  void add(Product p){



    actualProducts.add(p);
    notifyListeners();

  }

  void remove(Product p){

    actualProducts.remove(p);
    notifyListeners();

  }

}