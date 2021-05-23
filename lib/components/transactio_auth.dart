import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String pwd) onConfirm;

  const TransactionAuthDialog({@required this.onConfirm});

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Authenticate"),
      content: TextField(
        controller: _password,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: ()  {
            widget.onConfirm(_password.text);
            Navigator.pop(context);
          },
          child: Text("Confirm"),
        )
      ],
    );
  }
}
