import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/ui/_commons/drawer/custom_drawer.dart';
import 'package:flor_de_gato/ui/_commons/generic_dialogue.dart';
import 'package:flor_de_gato/ui/create_category/create_category_screen.dart';
import 'package:flor_de_gato/ui/create_movement/create_movement_screen.dart';
import 'components/list_category_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryTab extends StatefulWidget {
  final PageController pageController;

  InventoryTab(
    this.pageController,
  );

  @override
  _InventoryTabState createState() => _InventoryTabState();
}

class _InventoryTabState extends State<InventoryTab> {
  Product product = Product("", "", "", 0, 0, "");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Inventory",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        actions: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(right: 25),
            child: Text(
              context.watch<ProductController>().tot.toStringAsFixed(2) + " R\$",
              style: TextStyle(fontSize: 18, color: Color(0xFF442C2E)),
            ),
          ))
        ],
      ),
      body: Consumer<ProductController>(builder: (_, productController, __) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (final category in productController.categorys)
                  ListCategoryTile(
                    category: category,
                  ),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF442C2E),
        child: Icon(
          Icons.add,
          color: Color(0xFFFEEAE6),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context2) => GenericDialog(
              title: "What's new?",
              contentText: "",
              color: Color(0xFFFEDBD0),
              content: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return Color(0xFF442C2E);
                        })),
                        child: Text("Category",
                            style: TextStyle(
                              color: Color(0xFFFEDBD0),
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateCategory(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return Color(0xFF442C2E);
                        })),
                        child: Text(
                          "Movement",
                          style: TextStyle(
                            color: Color(0xFFFEDBD0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateMovement(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              submitButtonText: "",
              dismissButtonText: "",
              onSubmit: () {},
              submitButtonColor: Colors.red,
            ),
          );
        },
      ),
      drawer: CustomDrawer(widget.pageController),
    );
  }
}
