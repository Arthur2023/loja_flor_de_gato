import 'package:flor_de_gato/Controllers/client_controller.dart';
import 'package:flor_de_gato/Controllers/config_controller.dart';
import 'package:flor_de_gato/Controllers/product_controller.dart';
import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'package:flor_de_gato/helpers/date_formatter.dart';
import 'package:flor_de_gato/helpers/validators.dart';
import 'package:flor_de_gato/models/client.dart';
import 'package:flor_de_gato/models/configs.dart';
import 'package:flor_de_gato/models/product.dart';
import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/models/request_product.dart';
import 'package:flor_de_gato/ui/_commons/generic_dialogue.dart';
import 'package:flor_de_gato/ui/_commons/progress_dialogue.dart';
import 'package:flor_de_gato/ui/_commons/show_snack_bar.dart';
import 'package:flor_de_gato/ui/create_client/create_client_screen.dart';
import 'package:flor_de_gato/ui/search_client/client_search_screen.dart';
import 'package:flor_de_gato/ui/search_product/product_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'components/get_quantity_dialogue.dart';

class CreateRequest extends StatefulWidget {
  final Request request;
  final bool editing;

  CreateRequest({Request r})
      : editing = r != null,
        request = r?.clone() ?? Request("", "", "", 0, "", 0, description: "", state: "open");

  @override
  _CreateRequestState createState() => _CreateRequestState(request);
}

class _CreateRequestState extends State<CreateRequest> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final Request request;
  Client client = Client("", "");
  final clientController = TextEditingController();
  final estimatedTimeController = TextEditingController();
  final deliveryController = TextEditingController();
  final formOfPaymentController = TextEditingController();
  final estimatedDateController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  _CreateRequestState(this.request);

  @override
  void initState() {
    super.initState();
    estimatedTimeController.text = request.estimatedTime == 0 ? "" : request.estimatedTime.toStringAsFixed(1);
    deliveryController.text = request.delivery == 0 ? "" : request.delivery.toStringAsFixed(2);
    formOfPaymentController.text = request.formOfPayment;
    estimatedDateController.text = request.estimatedDate;
    titleController.text = request.title;
    descriptionController.text = request.description;
    request.products?.forEach(print);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editing) {
      client = context.watch<ClientController>().findID(request.client);
      clientController.text = client.name;
    }
    return ChangeNotifierProvider.value(
      value: request,
      builder: (_, __) {
        return Scaffold(
          key: scaffoldKey,
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
              Consumer<Request>(builder: (_, request, __) {
                Configs aux = context.watch<ConfigsController>().configs;
                print(request);
                print(request.totPrice(aux.priceHour, aux.margin));
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "${(request.totPrice(aux.priceHour, aux.margin)).toStringAsFixed(2)} R\$",
                    style: TextStyle(fontSize: 18, color: Color(0xFF442C2E)),
                  ),
                ));
              })
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Consumer<Request>(builder: (_, request, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            !widget.editing ? "Create a new request" : "Request",
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
                                child: TextFormField(
                                  controller: clientController,
                                  readOnly: true,
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
                                  validator: (text) {
                                    if (text.isEmpty) {
                                      return "Some information is still missing!";
                                    }

                                    return null;
                                  },
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
                                      if (request.isOpen) {
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
                                          request.client = client.id;
                                        }
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
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              readOnly: !request.isOpen,
                              controller: titleController,
                              decoration: InputDecoration(
                                labelText: "Title",
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
                                request.title = text;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              readOnly: !request.isOpen,
                              controller: formOfPaymentController,
                              decoration: InputDecoration(
                                labelText: "Form of Payment",
                                labelStyle: TextStyle(color: Color(0xFF442C2E)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF442C2E),
                                  ),
                                ),
                              ),
                              onSaved: (text) {
                                request.formOfPayment = text;
                              },
                            ),
                          ),
                          TextFormField(
                            readOnly: !request.isOpen,
                            controller: estimatedDateController,
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
                            inputFormatters: <TextInputFormatter>[DateFormatter()],
                            validator: (value) {
                              if (value.length == 10) {
                                return isValidDate(value);
                              } else {
                                return 'Invalid date';
                              }
                            },
                            onSaved: (text) {
                              request.estimatedDate = text;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              readOnly: !request.isOpen,
                              controller: descriptionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle: TextStyle(color: Color(0xFF442C2E)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF442C2E),
                                  ),
                                ),
                              ),
                              onSaved: (text) {
                                request.description = text;
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
                                    "${request.materialsPrice.toStringAsFixed(2)} R\$",
                                    style: TextStyle(
                                      color: Color(0xFF442C2E),
                                    ),
                                  ),
                                ],
                              ),
                              children: [
                                for (final rp in request.products ?? [])
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                    child: SizedBox(
                                      height: 35,
                                      child: Card(
                                        color: Colors.white,
                                        child: InkWell(
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder: (context2) => GenericDialog(
                                                  contentText: "Do you really want to delete ?",
                                                  title: "Delete",
                                                  submitButtonText: "Confirm",
                                                  onSubmit: () {
                                                    request.removeRequestProduct(rp);
                                                    Navigator.of(context).pop();
                                                  },
                                                  submitButtonColor: Colors.red[700],
                                                  dismissButtonColor: Colors.grey[700],
                                                  dismissButtonText: "Cancel",
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
                                                    rp.product.mark + ", " + rp.product.color,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    rp.quantity.toString(),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                if (request.isOpen)
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          child: Card(
                                            color: Color(0xFF442C2E),
                                            child: InkWell(
                                              child: SizedBox(
                                                height: 35,
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    Product aux = (await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => ProductSearch()),
                                                    ) as Product);
                                                    print(aux);
                                                    if (aux != null) {
                                                      int quantity = await showDialog(
                                                        context: context,
                                                        builder: (context2) => GetQuantityDialogue(request, aux),
                                                      );
                                                      print('QUANTITY $quantity');
                                                      if (quantity == null) return;

                                                      RequestProduct rp = RequestProduct.fromProduct(aux);
                                                      rp.quantity = quantity;
                                                      if (rp.product.quantity < quantity) return;
                                                      rp.price = ((rp.product.price / rp.product.quantity) * quantity);
                                                      rp.product.price -=
                                                          ((rp.product.price / rp.product.quantity) * quantity);

                                                      request.addRequestProduct(rp);
                                                    }
                                                  },
                                                  style: ButtonStyle(backgroundColor:
                                                      MaterialStateProperty.resolveWith<Color>(
                                                          (Set<MaterialState> states) {
                                                    return Color(0xFF442C2E);
                                                  })),
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
                              padding: EdgeInsets.only(top: 15, bottom: 5, left: 3),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      readOnly: !request.isOpen,
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
                                      onSaved: (text) {
                                        if (num.tryParse(text) != null)
                                          request.estimatedTime = num.tryParse(estimatedTimeController.text) ?? 0;
                                      },
                                    ),
                                  ),
                                  Container(
                                      color: Colors.white,
                                      child: IconButton(
                                        icon: Icon(Icons.check),
                                        onPressed: () {
                                          print("AQUI");
                                          request.changeEstimatedTime(num.parse(estimatedTimeController.text));
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
                                    readOnly: !request.isOpen,
                                    keyboardType: TextInputType.number,
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
                                    onSaved: (text) {
                                      if (num.tryParse(text) != null) request.delivery = num.parse(text) ?? 0;
                                    },
                                  ),
                                ),
                                Container(
                                    color: Colors.white,
                                    child: IconButton(
                                        icon: Icon(Icons.check),
                                        onPressed: () {
                                          request.changeDelivery(num.tryParse(deliveryController.text) ?? 0);
                                        }))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 45,
                          ),
                          if (request.isOpen)
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) => Color(0xFF442C2E)),
                                          shape: MaterialStateProperty.all<OutlinedBorder>(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          ),
                                        ),
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Color(0xFFFEEAE6), fontSize: 18),
                                        ),
                                        onPressed: () {
                                          if (widget.editing) {
                                            showDialog(
                                              context: context,
                                              builder: (context2) => GenericDialog(
                                                title: "cancellation",
                                                contentText: "Do you really want to cancel this order?",
                                                submitButtonText: "Confirm",
                                                submitButtonColor: Colors.red[800],
                                                onSubmit: () async {
                                                  progressDialog(context);
                                                  if (!await context.read<RequestController>().cancelRequest(request)) {
                                                    Navigator.of(context).pop();
                                                    showSnackBar(
                                                      text: "error updating order",
                                                      scaffoldKey: scaffoldKey,
                                                    );
                                                    print("Correct");
                                                    return;
                                                  }
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            );
                                          } else {
                                            Navigator.of(context).pop();
                                            print("certo");
                                            return;
                                          }
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 45,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                            (Set<MaterialState> states) => Color(0xFF442C2E)),
                                        shape: MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        ),
                                      ),
                                      child: Text(
                                        "Save",
                                        style: TextStyle(color: Color(0xFFFEEAE6), fontSize: 18),
                                      ),
                                      onPressed: () async {
                                        if (!formkey.currentState.validate()) return;
                                        formkey.currentState.save();
                                        Configs aux = context.read<ConfigsController>().configs;
                                        request.price = request.totPrice(aux.priceHour, aux.margin);
                                        progressDialog(context);
                                        if (widget.editing) {
                                          print('##############################################');
                                          if (!await context.read<RequestController>().update(request)) {
                                            Navigator.of(context).pop();
                                            showSnackBar(
                                              text: "Error updating order",
                                              scaffoldKey: scaffoldKey,
                                            );
                                            return;
                                          }
                                        } else if (!await context.read<RequestController>().save(request)) {
                                          Navigator.of(context).pop();
                                          showSnackBar(
                                            text: "Error adding order",
                                            scaffoldKey: scaffoldKey,
                                          );
                                          return;
                                        }
                                        print(request);
                                        await context.read<ProductController>().load();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 7),
                          if (widget.editing && request.isOpen)
                            SizedBox(
                              height: 50,
                              child: OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                          color: Colors.green[600],
                                        ),
                                      ),
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) => Colors.green[600]),
                                      shape: MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      )),
                                  child: Text(
                                    "Conclude",
                                    style: TextStyle(color: Colors.green[800], fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    progressDialog(context);
                                    if (!formkey.currentState.validate()) return;
                                    formkey.currentState.save();
                                    Configs aux = context.read<ConfigsController>().configs;
                                    request.price = request.totPrice(aux.priceHour, aux.margin);
                                    progressDialog(context);
                                    bool execute = await context.read<RequestController>().closeRequest(request);
                                    print(request.state);
                                    Navigator.of(context).pop();
                                    if (execute) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    } else {
                                      showSnackBar(text: "error when ending order", scaffoldKey: scaffoldKey);
                                    }
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
