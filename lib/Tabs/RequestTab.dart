import 'package:flor_de_gato/Pages/Creates/CreateRequest.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';

class RequestTab extends StatelessWidget {
  final PageController pageController;

  const RequestTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Requests",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF442C2E),
        child: Icon(
          Icons.add,
          color: Color(0xFFFEEAE6),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateRequest(),
            ),
          );
              },
    ),
      drawer: CustomDrawer(pageController),
    );
  }
}
