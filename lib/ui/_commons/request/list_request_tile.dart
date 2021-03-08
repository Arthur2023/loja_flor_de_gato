import 'package:flor_de_gato/Controllers/client_controller.dart';
import 'package:flor_de_gato/Controllers/config_controller.dart';
import 'package:flor_de_gato/models/client.dart';
import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/Pages/Creates/create_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRequestTile extends StatelessWidget {
  final Request request;

  const ListRequestTile({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Client client = context.watch<ClientController>().findID(request.client);
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        trailing: Padding(
          padding: EdgeInsets.only(right: 10, top:14),
            child: Text(request
                .totPrice(context.watch<ConfigsController>().configs.priceHour,
                    context.watch<ConfigsController>().configs.margin)
                .toStringAsFixed(2) + " R\$", style: TextStyle(color: Color(0xFFFEDBD0), fontSize: 15),)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateRequest(r: request),
            ),
          );
        },
        onLongPress: () {},
        tileColor: Color(0xFF442C2E),
        title: SizedBox(
            height: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    client.name,
                    style: TextStyle(fontSize: 25, color: Color(0xFFFEDBD0)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  request.title,
                  style: TextStyle(fontSize: 16, color: Color(0xFFFEDBD0)),
                  textAlign: TextAlign.start,
                )
              ],
            )),
      ),
    );
  }
}
