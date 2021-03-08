import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final String name;
  final int page;
  final PageController controller;
  final IconData icon;

  DrawerTile(this.name, this.page, this.controller, this.icon);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFFEDBD0),
      child: InkWell(
          onTap: (){
            Navigator.of(context).pop();
            controller.jumpToPage(page);
          },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
          child: Container(
            child: Row(
              children: [
                Icon(icon, size: 30),
                SizedBox(width: 30),
                Text(name, style: TextStyle(fontSize: 18),),
              ],
            )
          ),
        ),
      ),
    );
  }
}
