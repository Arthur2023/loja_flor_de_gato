import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetQuantityDialogue extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Product product;
  final Request request;
  final quantityController = TextEditingController();

  GetQuantityDialogue(this.request, this.product);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      backgroundColor: Color(0xFFFEDBD0),
      title: Text("Inform"),
      contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      scrollable: true,
      content: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Actual quantity: ${request.getAvaliableQuantityFromProductAtMoment(product)}",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 15, color: Color(0xFF442C2E)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity",
                labelStyle: TextStyle(color: Color(0xFF442C2E)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xFF442C2E),
                  ),
                ),
              ),
              controller: quantityController,
              validator: (text) {
                if (text.isEmpty) {
                  return "you need to inform how much we are going to spend on this project";
                } else if (int.tryParse(text) == null) {
                  return "Valor inválido";
                } else if (request.getAvaliableQuantityFromProductAtMoment(product) < int.tryParse(text)) {
                  return "Unavailable stock";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(primary: Colors.green[800]),
          onPressed: () {
            if (!formkey.currentState.validate()) return;
            int value = int.tryParse(quantityController.text);
            Navigator.pop(context, value);
          },
          child: Text("Confirm"),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.red[800]),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
