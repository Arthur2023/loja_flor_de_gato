import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';

class HistoricTab extends StatelessWidget {

  final PageController pageController;

  const HistoricTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Historic",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/fro.jpeg"), fit: BoxFit.cover),
          ),
          height: 510,
        ),
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}