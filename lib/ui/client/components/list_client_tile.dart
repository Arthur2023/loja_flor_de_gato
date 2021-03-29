import 'package:flor_de_gato/models/client.dart';
import 'package:flor_de_gato/ui/create_client/create_client_screen.dart';
import 'package:flutter/material.dart';

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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: client.image != null
                            ? NetworkImage(client.image)
                            : AssetImage("images/contact.png"),
                        fit: BoxFit.cover
                    ),
                  ),
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
