import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "All products",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final product
                  in context.watch<ProductController>().actualProducts)
                InkWell(
                  onTap: () {
                    Navigator.pop(context, product.clone());
                  },
                  child: Card(
                      color: Color(0xFF442C2E),
                      elevation: 5,
                      child: SizedBox(
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        color: Color(0xFFFEDBD0), fontSize: 17),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    product.mark,
                                    style: TextStyle(
                                        color: Color(0xFFFEDBD0), fontSize: 17),
                                  ),
                                ],
                              ),
                              Text(
                                product.color,
                                style: TextStyle(
                                    color: Color(0xFFFEDBD0), fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              SizedBox(
                height: 90,
              )
            ],
          ),
        ),
      ),
    );
  }
}
