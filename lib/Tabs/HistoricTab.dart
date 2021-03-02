import 'package:flor_de_gato/Controllers/MovementController.dart';
import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListMovimentTile.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListRequestTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoricTab extends StatelessWidget {
  final PageController pageController;

  const HistoricTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFEEAE6),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF442C2E)),
          backgroundColor: Color(0xFFFEDBD0),
          title: Text(
            "Historic",
            style: TextStyle(color: Color(0xFF442C2E)),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Color(0xFF442C2E),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.label_important_outline,
                  color: Color(0xFF442C2E),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.history,
                  color: Color(0xFF442C2E),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: [
                for (final request in context.watch<RequestController>().closedRequests)
                  ListRequestTile(
                    request: request,
                  ),
              ],
            ),
            ListView(
              children: [
                for (final movement in context.watch<MovementController>().movements)
                  ListMovementTile(movement),
              ],
            ),
          ],
        ),
        drawer: CustomDrawer(pageController),
      ),
    );
  }
}
