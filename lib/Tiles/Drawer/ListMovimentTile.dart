import 'package:flor_de_gato/Controllers/MovementController.dart';
import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Widgets/MovementDialog.dart';
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
        onTap: (){
          showDialog(context: context,
          builder: (context) => MovementDialog(movement: movement));
        },
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
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            product.mark,
                            style: TextStyle(fontSize: 20, color: Color(0xFFFEDBD0)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      context.watch<MovementController>().formatTimestamp(movement.date),
                      style: TextStyle(fontSize: 16, color: Color(0xFFFEDBD0)),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (movement.quantity > 0) ...[
                      Icon(
                        Icons.arrow_circle_up_outlined,
                        size: 25,
                        color: Colors.green,
                      ),
                    ] else
                      Icon(
                        Icons.arrow_circle_down_outlined,
                        size: 25,
                        color: Colors.red,
                      ),
                    const SizedBox(width: 8),
                    Text(
                      movement.quantity > 0 ? movement.quantity.toString() : (movement.quantity * -1).toString(),
                      style: TextStyle(fontSize: 25, color: Color(0xFFFEDBD0)),
                      textAlign: TextAlign.end,
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
