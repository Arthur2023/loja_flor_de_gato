import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GenericDialog extends StatelessWidget {

  final String title;
  final String contentText;
  final Widget content;

  Color dismissButtonColor;
  String dismissButtonText;
  VoidCallback onDismiss;
  Color color;

  final Color submitButtonColor;
  final String submitButtonText;
  final VoidCallback onSubmit;

  GenericDialog({
    @required this.title,
    @required this.contentText,
    @required this.submitButtonText,
    @required this.submitButtonColor,
    @required this.onSubmit,
    this.content,
    this.dismissButtonText = 'Cancel',
    this.dismissButtonColor,
    this.onDismiss,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (dismissButtonColor == null)
      dismissButtonColor = Theme.of(context).primaryColor;
    if (onDismiss == null) onDismiss = () => Navigator.pop(context);
    return AlertDialog(
      backgroundColor: color,
      title: Text(title),
      contentPadding: contentText == ''
          ? EdgeInsets.zero
          : EdgeInsets.fromLTRB(24, 24, 24, 0),scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(contentText),
          const SizedBox(height: 20),
          if (content != null) content,
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            onSubmit();
          },
          textColor: submitButtonColor,
          child: Text(submitButtonText),
        ),
        FlatButton(
          onPressed: onDismiss,
          textColor: dismissButtonColor,
          child: Text(dismissButtonText),
        ),
      ],
    );
  }
}
