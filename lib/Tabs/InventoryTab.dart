import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Pages/CreateCategory.dart';
import 'package:flor_de_gato/Pages/CreateMovement.dart';
import 'package:flor_de_gato/Pages/HomePage.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListCategoryTile.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListProductTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryTab extends StatelessWidget {
  final PageController pageController;
  Product product = Product("", "", "", 0, 0, "");

  InventoryTab(
    this.pageController,
  );

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
              "529 R\$",
              style: TextStyle(fontSize: 18, color: Color(0xFF442C2E)),
            ),
          ))
        ],
      ),
      body: Consumer<ProductController>(builder: (_, productController, __) {
        return ListView.builder(
          itemCount: productController.categorys.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
              child: ListCategoryTile(
                category: productController.categorys[index],
              ),
            );
          },
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
                      child: RaisedButton(
                        color: Color(0xFF442C2E),
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
                      child: RaisedButton(
                        color: Color(0xFF442C2E),
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
                              builder: (context) => HomePage(),
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
      drawer: CustomDrawer(pageController),
    );
  }
}
