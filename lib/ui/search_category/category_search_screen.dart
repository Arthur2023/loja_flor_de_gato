import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategorySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "All categorys",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final category in context.watch<ProductController>().categorys) Card(
                color: Color(0xFF442C2E),
                elevation: 5,
                child: InkWell(
                  onTap: (){

                    Navigator.pop(context, category);
                  },
                  child: SizedBox(
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                                Text(category.name, style: TextStyle(color: Color(0xFFFEDBD0), fontSize: 17),),
                          ],
                        ),
                      ),
                    ),
                ),
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
