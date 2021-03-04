import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/letras.png"), fit: BoxFit.contain)),
        ),
      ),
      color: Color(0xFFFEEAE6),
      elevation: 5,
    );
  }
}
