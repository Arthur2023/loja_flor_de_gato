import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flor_de_gato/Widgets/Validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateClient extends StatefulWidget {
  final Client client;
  final bool editing;

  CreateClient({Client c})
      : editing = c != null,
        client = c?.clone() ?? Client("", "");

  @override
  _CreateClientState createState() => _CreateClientState(client);
}

class _CreateClientState extends State<CreateClient> {
  final Client client;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  _CreateClientState(this.client);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Clients",
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
                      onSubmit: () {
                        // context.read<ClientController>().remove(c);
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
            Icon(Icons.account_circle_rounded,
                color: Color(0xFF442C2E), size: 125),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: client.name,
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
                        return "Seu cliente precisa de um nome!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      client.name = text;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
                      initialValue: client.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Color(0xFF442C2E)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF442C2E),
                          ),
                        ),
                      ),
                      validator: (text) {
                        if (!emailValid(text)) {
                          return "Email inválido!";
                        }
                        return null;
                      },
                      onSaved: (text) {
                        client.email = text;
                      },
                    ),
                  ),
                  TextFormField(
                    initialValue: client.phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Seu cliente precisa de um número!";
                      }
                      return null;
                    },
                    onSaved: (text) {
                      client.phone = text;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7),
                    child: TextFormField(
                      initialValue: client.address,
                      decoration: InputDecoration(
                        labelText: "Address",
                        labelStyle: TextStyle(color: Color(0xFF442C2E)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF442C2E),
                          ),
                        ),
                      ),
                      onSaved: (text) {
                        client.address = text;
                      },
                    ),
                  ),
                  TextFormField(
                    initialValue: client.cpf,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "CPF",
                      labelStyle: TextStyle(color: Color(0xFF442C2E)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF442C2E),
                        ),
                      ),
                    ),
                    onSaved: (text) {
                      client.cpf = text;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!formkey.currentState.validate()) return;
          progressDialog(context);
          print(client);
          formkey.currentState.save();
          print(client);
          if (widget.editing) {

          } else {
            await context.read<ClientController>().add(client);
          }
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        backgroundColor: Color(0xFF442C2E),
        child: Icon(Icons.save),
      ),
    );
  }
}
