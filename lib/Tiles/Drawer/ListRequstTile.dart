import 'package:flor_de_gato/Controllers/RequestController.dart';
import 'package:flor_de_gato/Models/Request.dart';
import 'package:flor_de_gato/Widgets/GenericDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRequestTile extends StatelessWidget {
  final Request request;

  const ListRequestTile({Key key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ListTile(
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Color(0xFF442C2E),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context2) => GenericDialog(
                title: "Confirmar",
                contentText: "Deseja excluir este pedido?",
                submitButtonText: "Excluir",
                submitButtonColor: Colors.red,
                onSubmit: () {
                  context.read<RequestController>().remove(request);
                },
                color: Color(0xFFFEEAE6),
                dismissButtonColor: Color(0xFF442C2E),
              ),
            );
          },
        ),
        onLongPress: () {},
        tileColor: Color(0xFFFEDBD0),
        title: Text(
          request.buyer + ", " + request.title,
          style: TextStyle(fontSize: 20, color: Color(0xFF442C2E)),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
