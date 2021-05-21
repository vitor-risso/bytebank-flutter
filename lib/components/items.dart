import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact _transfer;
  final Function onCLick;

  ContactItem(this._transfer, {@required this.onCLick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: ()=> onCLick(),
        title: Text(_transfer.name.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}
