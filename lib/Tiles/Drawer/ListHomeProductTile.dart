import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Models/Movement.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Pages/Creates/CreateRequest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListHomeProductTile extends StatelessWidget {
  final Movement movement;

  const ListHomeProductTile({Key key, this.movement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = context.watch<ProductController>().findProduct(movement.productID);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: SizedBox(
        height: 50,
        child: Card(
          color: Color(0xFF442C2E),
          child: InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            Text(product.mark, style: TextStyle(color: Color(0xFFFEDBD0)),),
                            const SizedBox(height: 2,),
                            Text(product.color, style: TextStyle(color: Color(0xFFFEDBD0), fontSize: 10),),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (movement.quantity > 0) ...[
                            Icon(
                              Icons.arrow_circle_up_outlined,
                              size: 15,
                              color: Colors.green,
                            ),
                          ] else
                            Icon(
                              Icons.arrow_circle_down_outlined,
                              size: 15,
                              color: Colors.red,
                            ),
                          // const SizedBox(width: 4),
                          // Text(
                          //   movement.quantity > 0 ? movement.quantity.toString() : (movement.quantity * -1).toString(),
                          //   style: TextStyle(fontSize: 20, color: Color(0xFFFEDBD0)),
                          //   textAlign: TextAlign.end,
                          // )
                        ],
                      ),
                    ]
                ),
              ),
          ),
        ),
      ),
    );
  }
}
