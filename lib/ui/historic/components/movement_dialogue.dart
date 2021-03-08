import 'package:flor_de_gato/Controllers/movement_controller.dart';
import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/models/movement.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovementDialog extends StatefulWidget {
  final Movement movement;

  const MovementDialog({Key key, this.movement}) : super(key: key);

  @override
  _MovementDialogState createState() => _MovementDialogState(movement);
}

class _MovementDialogState extends State<MovementDialog> {
  final Movement movement;

  final quantityController = TextEditingController();
  final colorController = TextEditingController();
  final productController = TextEditingController();
  final dateController = TextEditingController();
  final priceController = TextEditingController();
  final shoppingController = TextEditingController();

  _MovementDialogState(this.movement);

  @override
  void initState() {
    super.initState();
    quantityController.text =
        movement.quantity > 0 ? movement.quantity.toString() : (movement.quantity * -1).toString();
    priceController.text = movement.price == null ? "0" : movement.price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    Product product = context.watch<ProductController>().findProduct(widget.movement.productID);
    productController.text = product.mark;
    shoppingController.text = product.shopping;
    dateController.text = context.watch<MovementController>().formatTimestamp(movement.date);
    colorController.text = product.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical:85),
      child: Card(
        color: Color(0xFFFEEAE6),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 22, 12, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Movement",
                      style: TextStyle(color: Color(0xFF442C2E), fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Color(0xFF442C2E),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
              Divider(),
              TextField(
                controller: productController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Product",
                  labelStyle: TextStyle(color: Color(0xFF442C2E)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF442C2E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                controller: colorController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Color",
                  labelStyle: TextStyle(color: Color(0xFF442C2E)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF442C2E),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date",
                    labelStyle: TextStyle(color: Color(0xFF442C2E)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF442C2E),
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: quantityController,
                readOnly: true,
                decoration: InputDecoration(
                  suffix: Icon(
                    movement.quantity > 0 ? Icons.arrow_circle_up_outlined : Icons.arrow_circle_down_outlined,
                    color: Color(0xFF442C2E),
                    size: 23,
                  ),
                  prefix: Text("g ", style: TextStyle(color:Colors.grey)),
                  labelText: "Quantity",
                  labelStyle: TextStyle(color: Color(0xFF442C2E)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF442C2E),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: priceController,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefix: Text("R\$  ", style: TextStyle(color:Colors.grey)),
                    labelText: "Price",
                    labelStyle: TextStyle(color: Color(0xFF442C2E)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF442C2E),
                      ),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: shoppingController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Shopping",
                  labelStyle: TextStyle(color: Color(0xFF442C2E)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF442C2E),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
