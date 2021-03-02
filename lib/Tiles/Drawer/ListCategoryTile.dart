import 'package:flor_de_gato/Models/Category.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListProductTile.dart';
import 'package:flutter/material.dart';

class ListCategoryTile extends StatelessWidget {
  final Category category;

  const ListCategoryTile({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF442C2E),
      elevation: 5,
      child: ExpansionTile(
        title: Row(
          children: [
            Icon(Icons.local_florist_outlined, color: Color(0xFFFEDBD0),),
            SizedBox(width: 20),
            Text(category.name, style: TextStyle(color: Color(0xFFFEDBD0),),),
          ],
        ),
        children: [
          for (final product in category.products)
            if(product.quantity >0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:2.5),
              child: ListProductTile(
                product: product,
              ),
            ),
          const SizedBox(height: 5,)
        ],
      ),
    );
  }
}
