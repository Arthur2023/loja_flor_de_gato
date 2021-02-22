import 'package:flor_de_gato/Controllers/ClientController.dart';
import 'package:flor_de_gato/Models/Client.dart';
import 'package:flor_de_gato/Pages/CreateClient.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClientTile extends StatelessWidget {
  final Client client;

  const ListClientTile({Key key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateClient(
                c: client,
              ),
            ),
          );
        },
        child: Card(
          color: Color(0xFFFEDBD0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                child: Icon(
                  Icons.account_circle_rounded,
                  color: Color(0xFF442C2E),
                  size: 60,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 7, 5, 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      client.name ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text(client.email ?? "",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    Text(client.phone ?? "nulo",
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
