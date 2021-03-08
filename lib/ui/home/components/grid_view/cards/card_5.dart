import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'file:///C:/Users/Usuario/Desktop/ProjetosUdemy/Pessoais/flor_de_gato/lib/screens/base/home_request_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Card5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 3),
              child: Text(
                "Open orders",
                style: TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            if (context.watch<RequestController>().openRequests.length > 0) ...[
              for (final request in context.watch<RequestController>().openRequests)
                ListHomeRequestTile(request: request),
            ] else
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 115,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "images/uso.png",
                            ),
                            fit: BoxFit.contain)),
                  ),
                ),
              ),
          ],
        ),
      ),
      color: Color(0xFFFEEAE6),
      elevation: 5,
    );
  }
}
