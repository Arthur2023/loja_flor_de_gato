import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Category.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Pages/Search/CategorySearch.dart';
import 'package:flor_de_gato/Pages/Search/ProductSearch.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flor_de_gato/Widgets/ShowSnackBar.dart';
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
    quantityController.text = product.quantity.toString();
    priceController.text = product.price.toString();
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
        actions: [
          if (widget.editing)
            IconButton(
                color: Color(0xFF442C2E),
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context2) => GenericDialog(
                      title: "Confirmar",
                      contentText: "Deseja excluir este pedido?",
                      submitButtonText: "Excluir",
                      submitButtonColor: Colors.red,
                      onSubmit: () async {
                        progressDialog(context);
                        if (!await context
                            .read<ProductController>()
                            .remove(product)) {
                          Navigator.of(context).pop();
                          showSnackBar(
                            text: "Erro ao Excluir produto",
                            duration: Duration(seconds: 2),
                            scaffoldKey: scaffoldKey,
                          );
                          print(product);
                          return;
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                }),
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Product",
                    style: TextStyle(
                        color: Color(0xFF442C2E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
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
                        return "Ainda faltam algumas informacoes!";
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
                          return "Ainda faltam algumas informacoes!";
                        }
                        return null;
                      },
                      onSaved: (text) {
                        product.mark = text;
                      },
                    ),
                  ),
                  TextFormField(
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
                        return "Ainda faltam algumas informacoes!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      product.color = text;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
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
                          return "Ainda faltam algumas informacoes!";
                        }
                        return null;
                      },
                      onSaved: (text) {
                        product.shopping = text;
                      },
                    ),
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                        return "Ainda faltam algumas informacoes!";
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
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
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
                        return "Ainda faltam algumas informacoes!";
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
                    style: TextStyle(
                        color: Color(0xFF442C2E),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
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
                    return "Ainda faltam algumas informacoes!";
                  }
                  return null;
                },
                onSaved: (text) {
                  category.name = text;
                },
              ),
            ),
            SizedBox(height: 100)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!formkey.currentState.validate()) return;
          formkey.currentState.save();
          progressDialog(context);
          if (!await context.read<ProductController>().add(product, category)) {
            Navigator.of(context).pop();
            showSnackBar(
              text: "Erro ao adicionar cliente",
              scaffoldKey: scaffoldKey,
            );
            return;
          }

          print(product);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        backgroundColor: Color(0xFF442C2E),
        child: Icon(Icons.save),
      ),
    );
  }
}
