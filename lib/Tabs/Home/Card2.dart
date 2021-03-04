import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Card2 extends StatelessWidget {


  final PageController controller;

  const Card2(this.controller);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          controller.jumpToPage(1);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Open orders",
                style: TextStyle(color: Color(0xFFFEEAE6), fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                context.watch<RequestController>().openRequests.length.toString(),
                style: TextStyle(color: Color(0xFFFEEAE6), fontSize: 65),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      color: Color(0xFF442C2E),
      elevation: 5,
    );
  }
}
