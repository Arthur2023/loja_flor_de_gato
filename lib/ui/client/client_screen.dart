import 'package:flor_de_gato/Controllers/client_controller.dart';
import 'package:flor_de_gato/Pages/Creates/create_client_screen.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/client/list_client_tile.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/commons/custom_drawer.dart';
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
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
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
