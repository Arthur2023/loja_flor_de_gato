import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Pages/CreateClient.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListClientTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientTab extends StatelessWidget {
  final PageController pageController;

  const ClientTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Clients",
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
              builder: (context) => CreateClient(),
            ),
          );
        },
      ),
      body: Consumer<ClientController>(
        builder: (_, clientController, __) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: clientController.actualClients.length,
                itemBuilder: (context, index) {
                  return ListClientTile(
                      client: clientController.actualClients[index]);
                },
              ),
            ],
          );
        },
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}