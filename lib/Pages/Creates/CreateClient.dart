import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flor_de_gato/Widgets/ShowSnackBar.dart';
import 'package:flor_de_gato/Widgets/Validators.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  _CreateClientState(this.client);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: client,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF442C2E)),
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
                        onSubmit: () async {
                          progressDialog(context);
                          if (!await context
                              .read<ClientController>()
                              .remove(client)) {
                            Navigator.of(context).pop();
                            showSnackBar(
                              text: "Erro ao adicionar cliente",
                              scaffoldKey: scaffoldKey,
                            );
                            print(client);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                child: Consumer<Client>(builder: (_, client, __) {
                  return Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: client.file != null
                            ? FileImage(client.file)
                            : client.image != null
                                ? NetworkImage(client.image)
                                : AssetImage("images/contact.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }),
                onTap: () {
                  return showDialog(
                    context: context,
                    builder: (context2) => GenericDialog(
                      title: " Escolha a fonte da foto",
                      contentText: "",
                      submitButtonText: "câmera",
                      submitButtonColor: null,
                      onSubmit: () {
                        ImagePicker.pickImage(source: ImageSource.camera)
                            .then((file) {
                          if (file == null) return;
                          client.changeImage(file);
                        });
                        Navigator.pop(context);
                      },
                      dismissButtonText: "Galeria",
                      dismissButtonColor: Colors.blue,
                      onDismiss: () {
                        ImagePicker.pickImage(source: ImageSource.gallery)
                            .then((file) {
                          if (file == null) return;
                          client.changeImage(file);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
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
              SizedBox(height:90)
            ],
          ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!formkey.currentState.validate()) return;
            progressDialog(context);
            print(client);
            formkey.currentState.save();
            print(client);
            if (widget.editing) {
              if (!await context.read<ClientController>().update(client)) {
                Navigator.of(context).pop();
                showSnackBar(
                  text: "Erro ao atualizar cliente",
                  scaffoldKey: scaffoldKey,
                );
                return;
              }
            } else {
              if (!await context.read<ClientController>().add(client)) {
                Navigator.of(context).pop();
                showSnackBar(
                  text: "Erro ao adicionar cliente",
                  scaffoldKey: scaffoldKey,
                );
                return;
              }
            }
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          backgroundColor: Color(0xFF442C2E),
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
