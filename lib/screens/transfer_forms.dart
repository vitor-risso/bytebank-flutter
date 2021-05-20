import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Criando transferencia";

class TransferForms extends StatefulWidget {
  final TextEditingController _value = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();

  @override
  State<StatefulWidget> createState() {
    return _StateTransferForms();
  }
}

class _StateTransferForms extends State<TransferForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controller: widget._accountNumber,
                rotulo: "Numero da conta",
                tip: "000"),
            Editor(
                controller: widget._value,
                rotulo: "Valor",
                tip: "00.00",
                icon: Icons.monetization_on),
            ElevatedButton(
              onPressed: () {
                _createTransfer(context);
              },
              child: Text("Confirmar"),
            )
          ],
        ),
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final double value = double.tryParse(widget._value.text.toString());
    final int accountNUmber =
        int.tryParse(widget._accountNumber.text.toString());
    if (value != null && accountNUmber != null) {
      final Contact finalTransfer = Contact(value, accountNUmber);
      Navigator.pop(context, finalTransfer);
    }
  }
}