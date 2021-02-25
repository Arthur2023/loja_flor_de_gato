import 'package:flor_de_gato/Models/Product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GetQuantityDialogue extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Product product;
  final quantityController = TextEditingController();

  GetQuantityDialogue(this.product);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Informe"),
      contentPadding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      scrollable: true,
      content: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("quantidade atual: ${product.quantity}", textAlign: TextAlign.right, style: TextStyle(fontSize:15), ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantidade",
                labelStyle: TextStyle(color: Color(0xFF442C2E)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF442C2E),
                  ),
                ),
              ),
              controller: quantityController,
              validator: (text) {
                if (text.isEmpty) {
                  return "você precisa informar o quanto vamos gastar nesse projeto";
                } else if(int.tryParse(text) == null){
                  return "Valor inválido";
                } else if(product.quantity < int.tryParse(text)){
                  return "Estoque indisponível";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (!formkey.currentState.validate()) return;
            int value = int.tryParse(quantityController.text);
            Navigator.pop(context, value);
          },
          textColor: Colors.green,
          child: Text("Confirmar"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Colors.red,
          child: Text("Cancelar"),
        ),
      ],
    );
  }
}
