import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/movement.dart';
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
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Column(
                      children: [
                        Text(
                          product?.mark == null ? "" : product.mark,
                          style: TextStyle(color: Color(0xFFFEDBD0)),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          product?.color == null ? "" : product.mark,
                          style: TextStyle(color: Color(0xFFFEDBD0), fontSize: 10),
                        ),
                      ],
                    ),
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
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
