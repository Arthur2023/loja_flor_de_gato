import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListRequestTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricTab extends StatelessWidget {

  final PageController pageController;

  const HistoricTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Historic",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          for(final request in context.watch<RequestController>().closedRequests)
            ListRequestTile(request: request,)
        ],
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}