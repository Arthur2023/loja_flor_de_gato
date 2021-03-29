import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/models/category.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/ui/_commons/progress_dialogue.dart';
import 'package:flor_de_gato/ui/_commons/show_snack_bar.dart';
import 'package:flor_de_gato/ui/search_category/category_search_screen.dart';
import 'package:flor_de_gato/ui/search_product/product_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateMovement extends StatefulWidget {
  final Category category;
  final Product product;
  final bool editing;

  CreateMovement({Product p, Category c})
      : editing = p != null,
        product = p ?? Product("", "", "", 0, 0, ""),
        category = c ?? Category("");

  @override
  _CreateMovementState createState() => _CreateMovementState(product, category);
}

class _CreateMovementState extends State<CreateMovement> {
  final nameController = TextEditingController();
  final markController = TextEditingController();
  final colorController = TextEditingController();
  final shoppingController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final nameCategoryController = TextEditingController();

  final Product product;
  final Category category;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _CreateMovementState(this.product, this.category);

  @override
  void initState() {
    super.initState();
    nameController.text = product.name;
    markController.text = product.mark;
    colorController.text = product.color;
    shoppingController.text = product.shopping;
    quantityController.text = product.quantity == 0 ? "" : product.quantity.toStringAsFixed(0);
    priceController.text = product.price == 0 ? "" : product.price.toStringAsFixed(2);
    nameCategoryController.text = category.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Movement",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 5),
            if (!widget.editing)
              SwitchListTile(
                value: context.watch<ProductController>().typemov,
                onChanged: (value) {
                  context.read<ProductController>().typemov = value;
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.green[700],
                inactiveTrackColor: Colors.red[700],
              ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Product",
                    style: TextStyle(color: Color(0xFF442C2E), fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  if (!widget.editing)
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        Product aux = (await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductSearch(),
                          ),
                        ) as Product);
                        print(aux);
                        if (aux != null) {
                          setState(() {
                            product.desclone(aux);
                          });
                          nameController.text = product.name;
                          markController.text = product.mark;
                          colorController.text = product.color;
                          shoppingController.text = product.shopping;
                          quantityController.text = product.quantity.toString();
                          priceController.text = product.price.toString();
                          print(product);
                        }
                      },
                    ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    enabled: context.read<ProductController>().typemov,
                    readOnly: widget.editing,
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Some information is still missing!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      product.name = text;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
                      enabled: context.read<ProductController>().typemov,
                      readOnly: widget.editing,
                      controller: markController,
                      decoration: InputDecoration(
                        labelText: "Mark",
                        labelStyle: TextStyle(color: Color(0xFF442C2E)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF442C2E),
                          ),
                        ),
                      ),
                      validator: (text) {
                        if (text.isEmpty) {
                          return "Some information is still missing!";
                        }
                        return null;
                      },
                      onSaved: (text) {
                        product.mark = text;
                      },
                    ),
                  ),
                  TextFormField(
                    enabled: context.read<ProductController>().typemov,
                    readOnly: widget.editing,
                    controller: colorController,
                    decoration: InputDecoration(
                      labelText: "Color",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Some information is still missing!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      product.color = text;
                    },
                  ),
                  if (!widget.editing)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: TextFormField(
                        enabled: context.read<ProductController>().typemov,
                        controller: shoppingController,
                        decoration: InputDecoration(
                          labelText: "Shopping",
                          labelStyle: TextStyle(color: Color(0xFF442C2E)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF442C2E),
                            ),
                          ),
                        ),
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Some information is still missing!";
                          }
                          return null;
                        },
                        onSaved: (text) {
                          product.shopping = text;
                        },
                      ),
                    ),
                  if (widget.editing)
                    SizedBox(
                      height: 10,
                    ),
                  TextFormField(
                    readOnly: widget.editing,
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text("g ", style: TextStyle(color: Colors.grey)),
                      labelText: "Quantity",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Some information is still missing!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      product.quantity = num.parse(text);
                    },
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  if(context.watch<ProductController>().typemov ||
                      widget.editing)
                    TextFormField(
                    readOnly: widget.editing,
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text("R\$ ", style: TextStyle(color: Colors.grey)),
                      labelText: "Price",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Some information is still missing!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      product.price = num.parse(text);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(color: Color(0xFF442C2E), fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  if (!widget.editing)
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        Category aux = (await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategorySearch(),
                          ),
                        ) as Category);
                        print(aux);
                        if (aux != null) {
                          setState(() {
                            category.desclone(aux);
                            nameCategoryController.text = category.name;
                            print(category);
                          });
                        }
                      },
                    ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                readOnly: widget.editing,
                controller: nameCategoryController,
                decoration: InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Color(0xFF442C2E)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF442C2E),
                    ),
                  ),
                ),
                validator: (text) {
                  if (text.isEmpty) {
                    return "Some information is still missing!";
                  }
                  return null;
                },
                onSaved: (text) {
                  category.name = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 50, left: 10, right: 10),
              child: SizedBox(
                  height: 45,
                  child: widget.editing
                      ? null
                      : ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) => Color(0xFF442C2E)),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                    elevation: MaterialStateProperty.all(5)),
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          onPressed: () async {
                            if (!formkey.currentState.validate()) return;
                            formkey.currentState.save();
                            progressDialog(context);
                            if (!context.read<ProductController>().typemov) {
                              product.quantity = product.quantity * -1;
                              Product aux = ProductController().findProduct(product.id);
                              product.price = ((aux.price/aux.quantity)*product.quantity);
                            }

                            if (!await context.read<ProductController>().add(product, category)) {
                              Navigator.of(context).pop();
                              showSnackBar(
                                text: "Error adding movement",
                                scaffoldKey: scaffoldKey,
                              );
                              return;
                            }
                            print(product);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        )),
            ),
          ],
        ),
      )),
    );
  }
}
