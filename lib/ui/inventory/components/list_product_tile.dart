import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/models/category.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/ui/create_movement/create_movement_screen.dart';
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

        trailing: Text(
        product.quantity.toString()+"g",
        style: TextStyle(fontSize: 20, color: Color(0xFF442C2E)),
      ),
        onTap: () {
          print("aqui");
          Category category = context.read<ProductController>().findCategory(product.categoryID);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateMovement(p: product, c: category,),
            ),
          );
        },
      tileColor: Color(0xFFFEDBD0),
      title: Text(
        product.color,
        style: TextStyle(fontSize: 20, color: Color(0xFF442C2E)),
        textAlign: TextAlign.start,
      ),
        ),
      );
  }
}
