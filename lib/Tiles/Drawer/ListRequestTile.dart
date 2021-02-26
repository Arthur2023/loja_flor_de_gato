import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Pages/Creates/CreateRequest.dart';
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
        onTap: (){
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
                  padding: const EdgeInsets.symmetric(vertical:5),
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
