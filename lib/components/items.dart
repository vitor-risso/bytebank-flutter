import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact _transfer;

  ContactItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_transfer.name.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}
