import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListHomeRequestTile.dart';
import 'package:flor_de_gato/Tiles/Drawer/ListRequestTile.dart';
import 'package:flor_de_gato/Widgets/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  final PageController pageController;

  const HomeTab(this.pageController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF442C2E)),
        backgroundColor: Color(0xFFFEDBD0),
        title: Text(
          "Sweet Home",
          style: TextStyle(color: Color(0xFF442C2E)),
        ),
        centerTitle: true,
      ),
      body: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          itemCount: 5,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Card(elevation: 5, color: Color(0xFFFEEAE6));
            } else if (index == 1) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Pedidos abertos", style: TextStyle(color:Color(0xFFFEEAE6), fontSize: 15), textAlign: TextAlign.center,),
                      const SizedBox(height: 15,),
                      Text("3", style: TextStyle(color:Color(0xFFFEEAE6), fontSize: 65),textAlign:TextAlign.center,)
                    ],
                  ),
                ),
                color: Color(0xFF442C2E),
                elevation: 5,
              );
            }
            else if (index == 2) {
              return Card(
                child: Column(

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Pedidos Abertos", style: TextStyle(color:Colors.black, fontSize: 10),textAlign: TextAlign.center,),
                    ),
                    for(final request in context.watch<RequestController>().openRequests)
                      ListHomeRequestTile(request: request)
                  ],
                ),
                color: Color(0xFFFEEAE6),
                elevation: 5,
              );}
            else if (index == 3){
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Estoque", style: TextStyle(color:Color(0xFF442C2E), fontSize: 15), textAlign: TextAlign.center,),
                    const SizedBox(height: 20,),
                    Text("512,00 ", style: TextStyle(color:Color(0xFF442C2E), fontSize: 35),textAlign:TextAlign.center,)
                  ],
                ),
              ),
            color: Color(0xFFFEEAE6),
            elevation: 5,
            );
            }else if (index == 4){
            return Card(
            color: Color(0xFFFEEAE6),
            elevation: 5,
            );
            } return null;
          },
          staggeredTileBuilder: (index) {
            if (index == 0) {
              return StaggeredTile.count(1, 0.5);
            } else if (index == 1) {
              return StaggeredTile.count(1, 1);
            } else if (index == 2) {
              return StaggeredTile.count(1, 1.5);
            } else if (index == 3) {
              return StaggeredTile.count(1, 1);
            } else if (index == 4) {
              return StaggeredTile.count(2, 1);
            } else {
              return StaggeredTile.count(1, 1);
            }
          }),
      drawer: CustomDrawer(pageController),
    );
  }
}
