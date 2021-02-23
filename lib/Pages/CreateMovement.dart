// import 'package:flor_de_gato/Controllers/ClientController.dart';
// import 'package:flor_de_gato/Models/Client.dart';
// import 'package:flor_de_gato/Widgets/GenericDialog.dart';
// import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
// import 'package:flor_de_gato/Widgets/ShowSnackBar.dart';
// import 'package:flor_de_gato/Widgets/Validators.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// class CreateMovement extends StatefulWidget {
//   final Client client;
//   final bool editing;
//
//   CreateMovement({Client c})
//       : editing = c != null,
//         client = c?.clone() ?? Client("", "");
//
//   @override
//   _CreateMovementState createState() => _CreateMovementState(client);
// }
//
// class _CreateMovementState extends State<CreateMovement> {
//   final Client client;
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   _CreateMovementState(this.client);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: client,
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Color(0xFFFEDBD0),
//           title: Text(
//             "Movement",
//             style: TextStyle(color: Color(0xFF442C2E)),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: formkey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 SizedBox(height: 20),
//                 Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         child: TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Type",
//                             labelStyle: TextStyle(
//                                 color: Color(0xFF442C2E), fontSize: 15),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color(0xFF442C2E),
//                               ),
//                             ),
//                           ),
//                           validator: (text) {
//                             if (text.isEmpty) {
//                               return "some information is still missing";
//                             }
//                             return null;
//                           },
//                           onSaved: (text) {
//                             product.name = text;
//                           },
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 7),
//                         child: TextFormField(
//                             decoration: InputDecoration(
//                               labelText: "Mark",
//                               labelStyle: TextStyle(
//                                   color: Color(0xFF442C2E), fontSize: 15),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Color(0xFF442C2E),
//                                 ),
//                               ),
//                             ),
//                             validator: (text) {
//                               if (text.isEmpty) {
//                                 return "some information is still missing";
//                               }
//                               return null;
//                             },
//                             onSaved: (text) {
//                               if (text.isEmpty) {
//                                 return "some information is still missing";
//                               } else {
//                                 product.mark = text;
//                               }
//                             }),
//                       ),
//                       TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Color",
//                             labelStyle: TextStyle(
//                                 color: Color(0xFF442C2E), fontSize: 15),
//                             hintText: "cod",
//                             hintStyle: TextStyle(color: Color(0xFF442C2E)),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color(0xFF442C2E),
//                               ),
//                             ),
//                           ),
//                           validator: (text) {
//                             if (text.isEmpty) {
//                               return "some information is still missing";
//                             }
//                             return null;
//                           },
//                           onSaved: (text) {
//                             if (text.isEmpty) {
//                               return "some information is still missing";
//                             } else {
//                               product.color = text;
//                             }
//                           }),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 7),
//                         child: TextFormField(
//                             decoration: InputDecoration(
//                               labelText: "Quantity",
//                               labelStyle: TextStyle(
//                                   color: Color(0xFF442C2E), fontSize: 15),
//                               hintText: "gramas",
//                               hintStyle: TextStyle(color: Color(0xFF442C2E)),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Color(0xFF442C2E),
//                                 ),
//                               ),
//                             ),
//                             validator: (text) {
//                               if (text.isEmpty) {
//                                 return "some information is still missing";
//                               }
//                               return null;
//                             },
//                             onSaved: (text) {
//                               // TODO: validar se e numerico
//                               if (text.isEmpty) {
//                                 return "some information is still missing";
//                               } else {
//                                 product.quantity = num.parse(text);
//                               }
//                             }),
//                       ),
//                       TextFormField(
//                           decoration: InputDecoration(
//                             labelText: "Price",
//                             labelStyle: TextStyle(
//                                 color: Color(0xFF442C2E), fontSize: 15),
//                             hintText: "total R\$",
//                             hintStyle: TextStyle(color: Color(0xFF442C2E)),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Color(0xFF442C2E),
//                               ),
//                             ),
//                           ),
//                           validator: (text) {
//                             if (text.isEmpty) {
//                               return "some information is still missing";
//                             }
//                             return null;
//                           },
//                           onSaved: (text) {
//                             // TODO: validar se e numerico
//                             if (text.isEmpty) {
//                               return "some information is still missing";
//                             } else {
//                               product.price = num.parse(text);
//                             }
//                           }),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             if (!formkey.currentState.validate()) return;
//             progressDialog(context);
//             print(client);
//             formkey.currentState.save();
//             print(client);
//             if (widget.editing) {
//               if (!await context.read<ClientController>().update(client)) {
//                 Navigator.of(context).pop();
//                 showSnackBar(
//                   text: "Erro ao atualizar cliente",
//                   scaffoldKey: scaffoldKey,
//                 );
//                 return;
//               }
//             } else {
//               if (!await context.read<ClientController>().add(client)) {
//                 Navigator.of(context).pop();
//                 showSnackBar(
//                   text: "Erro ao adicionar cliente",
//                   scaffoldKey: scaffoldKey,
//                 );
//                 return;
//               }
//             }
//             Navigator.of(context).pop();
//             Navigator.of(context).pop();
//           },
//           backgroundColor: Color(0xFF442C2E),
//           child: Icon(Icons.save),
//         ),
//       ),
//     );
//   }
// }
