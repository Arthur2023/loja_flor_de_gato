import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListProductTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryTab extends StatelessWidget {
  final PageController pageController;
  Product product = Product("", "", "", "", "");

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
      ),
      body: Consumer<ProductController>(builder: (_, productController, __) {
        return Stack(
          children: [
            ListView.builder(
                itemCount: productController.actualProducts.length,
                itemBuilder: (context, index) {
                  return ListProductTile(
                      product: productController.actualProducts[index]);
                }),
          ],
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
              title: "Create Input",
              contentText: "",
              submitButtonText: "Create",
              submitButtonColor: Color(0xFF442C2E),
              onSubmit: () {
                if (!formkey.currentState.validate()) {
                  return;
                } else {
                  progressDialog(context);
                  print(product);
                  formkey.currentState.save();
                  context.read<ProductController>().add(product);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              color: Color(0xFFFEDBD0),
              dismissButtonColor: Color(0xFF442C2E),
              content: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Type",
                              labelStyle: TextStyle(
                                  color: Color(0xFF442C2E), fontSize: 15),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF442C2E),
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (text.isEmpty) {
                                return "some information is still missing";
                              } return null;
                            },
                            onSaved: (text) {
                                product.name = text;
                                },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Mark",
                                labelStyle: TextStyle(
                                    color: Color(0xFF442C2E), fontSize: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF442C2E),
                                  ),
                                ),
                              ),
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "some information is still missing";
                                } return null;
                              },
                              onSaved: (text) {
                                if (text.isEmpty) {
                                  return "some information is still missing";
                                } else {
                                  product.mark = text;
                                }
                              }),
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Color",
                              labelStyle: TextStyle(
                                  color: Color(0xFF442C2E), fontSize: 15),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF442C2E),
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (text.isEmpty) {
                                return "some information is still missing";
                              } return null;
                            },
                            onSaved: (text) {
                              if (text.isEmpty) {
                                return "some information is still missing";
                              } else {
                                product.color = text;
                              }
                            }),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Quantity",
                                labelStyle: TextStyle(
                                    color: Color(0xFF442C2E), fontSize: 15),
                                hintText: "gramas",
                                hintStyle: TextStyle(color: Color(0xFF442C2E)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF442C2E),
                                  ),
                                ),
                              ),
                              validator: (text) {
                                if (text.isEmpty) {
                                  return "some information is still missing";
                                } return null;
                              },
                              onSaved: (text) {
                                if (text.isEmpty) {
                                  return "some information is still missing";
                                } else {
                                  product.quantity = text;
                                }
                              }),
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Price",
                              labelStyle: TextStyle(
                                  color: Color(0xFF442C2E), fontSize: 15),
                              hintText: "total R\$",
                              hintStyle: TextStyle(color: Color(0xFF442C2E)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF442C2E),
                                ),
                              ),
                            ),
                            validator: (text) {
                              if (text.isEmpty) {
                                return "some information is still missing";
                              } return null;
                            },
                            onSaved: (text) {
                              if (text.isEmpty) {
                                return "some information is still missing";
                              } else {
                                product.price = text;
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}
