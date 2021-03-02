import 'package:flor_de_gato/Tiles/Drawer/DrawerTile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;
  CustomDrawer(this.pageController);

  Widget backGroundColor() => Container(
        color: Color(0xFFFEDBD0),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
      children: [
        backGroundColor(),
        ListView(
          padding: EdgeInsets.symmetric(),
          children: <Widget>[
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   image: DecorationImage(
              //       image:AssetImage("images/nature1.jpg"),
              //   fit: BoxFit.cover
              //   ),
              // ),
              height: 225,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Text(
                      "Flor\nde\nGato",
                      style: TextStyle(color: Color(0xFF442C2E), fontSize: 50),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    child: Text(
                      "R.H.S",
                      style: TextStyle(color: Color(0xFF442C2E), fontSize: 15),
                    ),
                  ),
                  Positioned(
                    bottom: 1.5,
                    right: 12,
                    child: Icon(
                      Icons.local_florist_outlined, color: Color(0xFF442C2E), size: 11,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xFF442C2E),
              height: 2,
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: DrawerTile("Begin", 0, pageController, Icons.home),
            ),
            DrawerTile(
                "Requests", 1, pageController, Icons.label_important_outline),
            DrawerTile("Clients", 2, pageController, Icons.people),
            DrawerTile("Inventory", 3, pageController, Icons.inventory),
            DrawerTile("Historic", 4, pageController, Icons.history),
            DrawerTile("Settings", 5, pageController, Icons.settings),
          ],
        ),
      ],
    ));
  }
}
