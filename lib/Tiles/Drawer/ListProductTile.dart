import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProductTile extends StatelessWidget {

  final Product product;

  const ListProductTile({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5),
      child: ListTile(
        trailing: IconButton(icon: Icon(Icons.delete, color: Color(0xFF442C2E),),
        onPressed: (){
          showDialog(
            context: context,
            builder: (context2) => GenericDialog(
              title: "Confirmar",
              contentText: "Deseja excluir este pedido?",
              submitButtonText: "Excluir",
              submitButtonColor: Colors.red,
              onSubmit: () {
                context.read<ProductController>().remove(product);
              },
              color: Color(0xFFFEEAE6),
              dismissButtonColor: Color(0xFF442C2E),
            ),
          );
        },),
        onLongPress: (){},
        tileColor: Color(0xFFFEDBD0),
        title: Text(
          product.name + " " + product.mark +  ", " + product.color,
          style: TextStyle(fontSize: 20, color: Color(0xFF442C2E)),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}