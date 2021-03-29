import 'package:flor_de_gato/Controllers/movement_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_product_tile.dart';

class Card3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    num i;
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 3),
              child: Text(
                "Last movements",
                style: TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            if (context.watch<MovementController>().isLoading)
              Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF442C2E)),
              ))
            else
              for (i = 0; i < 5; i++) ListHomeProductTile(movement: context.watch<MovementController>().movements[i])
          ],
        ),
      ),
      color: Color(0xFFFEEAE6),
      elevation: 5,
    );
  }
}
