import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Models/Product.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Pages/Creates/CreateClient.dart';
import 'package:flor_de_gato/Pages/Search/ClientSearch.dart';
import 'package:flor_de_gato/Pages/Search/ProductSearch.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flor_de_gato/Widgets/ShowSnackBar.dart';
import 'package:flor_de_gato/Widgets/getQuantityDialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateRequest extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Client client = Client("", "");
  Product product = Product("", "", "", 0, 0, "");
  Request request = Request("", "", "", "", "", 0);
  final clientController = TextEditingController();
  final estimatedTimeController = TextEditingController();
  final deliveryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Request",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
        actions: [
          Center(
              child: Padding(
            padding: EdgeInsets.only(right: 25),
            child: Text(
              "${context.watch<RequestController>().totPrice.toStringAsFixed(2)} R\$",
              style: TextStyle(fontSize: 18, color: Color(0xFF442C2E)),
            ),
          ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create a new request",
                      style: TextStyle(color: Color(0xFF442C2E), fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: clientController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.add, color: Colors.grey),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CreateClient(),
                                    ),
                                  );
                                },
                              ),
                              hintText: "Client",
                              hintStyle: TextStyle(color: Color(0xFF442C2E)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF442C2E),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                            height: 55,
                            width: 50,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Color(0xFF442C2E),
                              ),
                              onPressed: () async {
                                Client aux = (await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientSearch(),
                                  ),
                                ) as Client);
                                print(aux);
                                if (aux != null) {
                                  client = aux;
                                  clientController.text = client.name;
                                }
                              },
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                gradient: LinearGradient(
                                    colors: [Color(0xFFFEEAE6), Color(0xFFFEEAE6), Color(0xFFFEDBD0)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(10)))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Form of Payment",
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
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: "Estimated Date",
                        labelStyle: TextStyle(color: Color(0xFF442C2E)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF442C2E),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Description",
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
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 25, bottom: 5),
                        child: Text(
                          "Price",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                          textAlign: TextAlign.center,
                        )),
                    Divider(),
                    Card(
                      color: Color(0xFFFEEAE6),
                      elevation: 5,
                      child: ExpansionTile(
                        title: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              "Materials",
                              style: TextStyle(
                                color: Color(0xFF442C2E),
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              "${context.watch<RequestController>().materialsPrice.toStringAsFixed(2)} R\$",
                              style: TextStyle(
                                color: Color(0xFF442C2E),
                              ),
                            ),
                          ],
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (final product in context.watch<RequestController>().requestProducts)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    height: 35,
                                    child: Card(
                                      color: Colors.white,
                                      child: InkWell(
                                          onLongPress: () {
                                            showDialog(
                                              context: context,
                                              builder: (context2) => GenericDialog(
                                                contentText: "Deseja realmente excluir?",
                                                title: "Excluir",
                                                submitButtonText: "Confirmar",
                                                onSubmit: () {
                                                  context.read<RequestController>().removeProduct(product);
                                                  Navigator.of(context).pop();
                                                },
                                                submitButtonColor: Colors.red[700],
                                                dismissButtonColor: Colors.grey[700],
                                                dismissButtonText: "Cancelar",
                                                color: Color(0xFFFEDBD0),
                                              ),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  product.mark + ", " + product.color,
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  product.quantity.toString(),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                child: Card(
                                  color: Color(0xFF442C2E),
                                  child: InkWell(
                                    child: SizedBox(
                                      height: 35,
                                      child: Expanded(
                                        child: RaisedButton(
                                          onPressed: () async {
                                            Product aux = (await Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProductSearch()),
                                            ) as Product);
                                            print(aux);
                                            if (aux != null) {
                                              int quantity = await showDialog(
                                                context: context,
                                                builder: (context2) => GetQuantityDialogue(aux),
                                              );

                                              if (quantity == null) return;
                                              product = aux;
                                              if (product.quantity < quantity) return;
                                              product.price = (product.price / product.quantity) * quantity;
                                              product.quantity = quantity;

                                              await context.read<RequestController>().addProduct(product);
                                            }
                                          },
                                          color: Color(0xFF442C2E),
                                          child: Text(
                                            "Add more",
                                            style: TextStyle(
                                              color: Color(0xFFFEEAE6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 5, left: 3),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: estimatedTimeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Estimated Time",
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
                              ),
                            ),
                            Container(
                                color: Colors.white,
                                child: IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    print("AQUI");
                                    context.read<RequestController>().estimatedTime =
                                        num.tryParse(estimatedTimeController.text) ?? 0;
                                  },
                                )),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 3),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: deliveryController,
                              decoration: InputDecoration(
                                labelText: "delivery",
                                labelStyle: TextStyle(color: Color(0xFF442C2E)),
                                hintText: "No delivery",
                                hintStyle: TextStyle(color: Colors.grey),
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
                            ),
                          ),
                          Container(
                              color: Colors.white,
                              child: IconButton(
                                  icon: Icon(Icons.check),
                                  onPressed: () {
                                    context.read<RequestController>().delivery =
                                        num.tryParse(deliveryController.text) ?? 0;
                                  }))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!formkey.currentState.validate()) return;
          formkey.currentState.save();
          progressDialog(context);
          if (!await context.read<RequestController>().add(request)) {
            Navigator.of(context).pop();
            showSnackBar(
              text: "Erro ao adicionar cliente",
              scaffoldKey: scaffoldKey,
            );
            return;
          }
          print(request);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        backgroundColor: Color(0xFF442C2E),
        child: Icon(Icons.save),
      ),
    );
  }
}
