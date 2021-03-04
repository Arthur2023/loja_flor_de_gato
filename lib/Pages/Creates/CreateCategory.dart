import 'package:flor_de_gato/Controllers/ProductController.dart';
import 'package:flor_de_gato/Models/Category.dart';
import 'package:flor_de_gato/Widgets/ProgressDialogue.dart';
import 'package:flor_de_gato/Widgets/ShowSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  Category category = Category("");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFFFEDBD0),
          title: Text(
            "Category",
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        TextFormField(
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
                              return "Your category needs a name!";
                            }
                            return null;
                          },
                          onSaved: (text) {
                            category.name = text;
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
            formkey.currentState.save();
            progressDialog(context);
            if (!await await context.read<ProductController>().addCategory(category)) {
              Navigator.of(context).pop();
              showSnackBar(
                text: "Error adding category",
                scaffoldKey: scaffoldKey,
              );
              return;
            }

            print(category);
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
