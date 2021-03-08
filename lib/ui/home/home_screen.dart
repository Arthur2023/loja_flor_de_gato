import 'package:flor_de_gato/Tabs/Home/card_1.dart';
import 'package:flor_de_gato/Tabs/Home/card_2.dart';
import 'package:flor_de_gato/Tabs/Home/card_3.dart';
import 'package:flor_de_gato/Tabs/Home/card_4.dart';
import 'package:flor_de_gato/Tabs/Home/card_5.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/commons/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../base/home/card_6.dart';

class HomeTab extends StatelessWidget {

  final PageController pageController;

  const HomeTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Sweet Home",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: 6,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Card1();
            } else if (index == 1) {
              return Card2(pageController);
            }
            else if (index == 2) {
              return Card3();}
            else if (index == 3){
            return Card4(pageController);
            }else if (index == 4){
            return Card5();
            } else if (index == 5){
              return Card6();
            } return null;
          },
          staggeredTileBuilder: (index) {
            if (index == 0) {
              return StaggeredTile.count(1,0.5);
            } else if (index == 1) {
              return StaggeredTile.count(1, 1);
            } else if (index == 2) {
              return StaggeredTile.count(1, 1.5);
            } else if (index == 3) {
              return StaggeredTile.count(1, 1);
            } else if (index == 4) {
              return StaggeredTile.count(2, 1);
            } else if(index == 5){
              return StaggeredTile.count(2, 1.5);
            } else {
            return StaggeredTile.count(1, 1);
            }
          }),
      drawer: CustomDrawer(pageController),
    );
  }
}
