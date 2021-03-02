import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListMovementTile extends StatelessWidget {
  final Movement movement;

  const ListMovementTile(this.movement);

  @override
  Widget build(BuildContext context) {
    Product product = context.watch<ProductController>().findProduct(movement.productID);
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        tileColor: Color(0xFF442C2E),
        title: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:5),
                          child: Text(
                            product.mark,
                            style: TextStyle(fontSize: 25, color: Color(0xFFFEDBD0)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Text(product.color, style: TextStyle(fontSize: 25, color: Color(0xFFFEDBD0)),
                          textAlign: TextAlign.start,)
                      ],
                    ),
                    Text(
                      movement.date,
                      style: TextStyle(fontSize: 16, color: Color(0xFFFEDBD0)),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Text( movement.quantity.toString(), style: TextStyle(fontSize: 35, color: Color(0xFFFEDBD0)),
                  textAlign: TextAlign.end,)
              ],
            )),
      ),
    );
  }
}
