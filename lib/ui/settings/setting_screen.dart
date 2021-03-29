
import 'package:flor_de_gato/ui/_commons/drawer/custom_drawer.dart';
import 'package:flor_de_gato/ui/settings/price/price_screen.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  final PageController pageController;

  const SettingsTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Settings",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 10, 8, 5),
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states){
                  return Color(0xFFFEDBD0);
                  }
                  ),
                ),
                child: Text(
                  "Price",
                  style: TextStyle(color: Color(0xFF442C2E), fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PriceScreen()));
                },
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}
