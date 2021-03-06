import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'package:flor_de_gato/ui/_commons/drawer/custom_drawer.dart';
import 'package:flor_de_gato/ui/_commons/request/list_request_tile.dart';
import 'package:flor_de_gato/ui/create_request/create_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestTab extends StatelessWidget {
  final PageController pageController;

  const RequestTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEEAE6),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Requests",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF442C2E),
        child: Icon(
          Icons.add,
          color: Color(0xFFFEEAE6),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateRequest(),
            ),
          );
              },
    ),
      body: ListView(
        children: [
          for(final request in context.watch<RequestController>().openRequests)
            ListRequestTile(request: request),
          SizedBox(height: 90,)
        ],
      ),
      drawer: CustomDrawer(pageController),
    );
  }
}
