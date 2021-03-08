import 'package:flutter/material.dart';

void progressDialog(BuildContext context, {String text}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    child: ProgressWidget(text: text),
  );
}

class ProgressWidget extends StatelessWidget {
  final String text;

  const ProgressWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return text == null
        ? Center(
      child: Card(
        color: Colors.black38,
        child: Container(
          height: 80,
          width: 80,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    )
        : Center(
      child: Card(
        color: Colors.black87,
        child: Container(
          height: 140,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
