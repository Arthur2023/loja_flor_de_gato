import 'package:flor_de_gato/Controllers/movement_controller.dart';
import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'package:flor_de_gato/ui/_commons/drawer/custom_drawer.dart';
import 'package:flor_de_gato/ui/_commons/request/list_request_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/list_movement_tile.dart';

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
