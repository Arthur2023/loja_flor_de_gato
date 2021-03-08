import 'package:flor_de_gato/Controllers/client_controller.dart';
import 'package:flor_de_gato/Controllers/request_controller.dart';
import 'package:flor_de_gato/models/request.dart';
import 'package:flor_de_gato/models/client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListHomeRequestTile extends StatelessWidget {
  final Request request;

  const ListHomeRequestTile({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Client client = context.watch<ClientController>().findID(request.client);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: SizedBox(
        height: 50,
        child: Card(
            child: Padding(
          padding: EdgeInsets.only(left: 15, right: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(client.name),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove, size: 12),
                      onPressed: () {
                        context.read<RequestController>().homeChangeEstimatedTime(-0.5, request);
                      }),
                  Text(request.estimatedTime.toStringAsFixed(1)),
                  IconButton(
                      icon: Icon(Icons.add, size: 12),
                      onPressed: () {
                        context.read<RequestController>().homeChangeEstimatedTime(0.5, request);
                      }),
                ],
              ),
              color: Colors.white,
              height: 30,
              width: 125,
            )
          ]),
        )),
      ),
    );
  }
}
