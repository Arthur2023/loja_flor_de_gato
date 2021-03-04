import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Card4 extends StatelessWidget {

  final PageController controller;

  const Card4(this.controller);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          controller.jumpToPage(3);
        },
        child:Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "inventory",
              style: TextStyle(color: Color(0xFF442C2E), fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              context.watch<ProductController>().tot.toStringAsFixed(2),
              style: TextStyle(color: Color(0xFF442C2E), fontSize: 35),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      ),
      color: Color(0xFFFEEAE6),
      elevation: 5,
    );
  }
}
