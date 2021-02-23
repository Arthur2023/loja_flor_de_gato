import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListRequstTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          showDialog(
            context: context,
            builder: (context2) => GenericDialog(
              title: "Criar Pedido",
              contentText: "",
              submitButtonText: "Criar",
              submitButtonColor: Color(0xFF442C2E),
              onSubmit: () {
                context.read<RequestController>().add(
                      Request("Urso", "Emily"),
                    );
              },
              color: Color(0xFFFEDBD0),
              dismissButtonColor: Color(0xFF442C2E),
            ),
          );
        },
      ),
      body: Consumer<RequestController>(builder: (_, requestController, __) {
        return Stack(
          children: [
            ListView.builder(
                itemCount: requestController.actualRequests.length,
                itemBuilder: (context, index) {
                  return ListRequestTile(
                      request: requestController.actualRequests[index]);
                }),
          ],
        );
      }),
      drawer: CustomDrawer(pageController),
    );
  }
}
