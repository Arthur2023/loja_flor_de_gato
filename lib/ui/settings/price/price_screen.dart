import 'package:flor_de_gato/Controllers/config_controller.dart';
import 'package:flor_de_gato/ui/_commons/progress_dialogue.dart';
import 'package:flor_de_gato/ui/_commons/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final priceHourController = TextEditingController();

  final marginController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Price",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Form(
          key: formkey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Container(
                    width: 175,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "working hour:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: context.watch<ConfigsController>().configs.priceHour.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text(
                        "R\$ ",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return "Required field";
                      return null;
                    },
                    onSaved: (text) {
                      context.read<ConfigsController>().configs.priceHour = num.parse(text);
                    },
                  )),
                  const SizedBox(width: 15)
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 175,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "applied margin:",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextFormField(
                    initialValue: context.watch<ConfigsController>().configs.margin.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefix: Text(
                        "% ",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty) return "Required field";
                      return null;
                    },
                    onSaved: (text) {
                      context.read<ConfigsController>().configs.margin = num.parse(text);
                    },
                  )),
                  const SizedBox(width: 15)
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                    return Color(0xFF442C2E);
                  })),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () async {
                    if (!formkey.currentState.validate()) return;
                    formkey.currentState.save();
                    progressDialog(context);
                    if (!await context.read<ConfigsController>().update()) {
                      Navigator.of(context).pop();
                      showSnackBar(
                        text: "Saving error",
                        scaffoldKey: scaffoldKey,
                      );
                      return;
                    }
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
