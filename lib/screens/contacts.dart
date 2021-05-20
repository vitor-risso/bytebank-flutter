
import 'package:bytebank/components/items.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Tranferencias";

class Contacts extends StatefulWidget {
  final List<Transfer> _transferList = [];

  @override
  State<StatefulWidget> createState() {
    return StateTransferList();
  }
}

class StateTransferList extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transferList.length,
        itemBuilder: (context, index) {
          final transfer = widget._transferList[index];
          return TransferItem(transfer);
        },
      ),
      appBar: AppBar(title: Text(_appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForms();
          }));
          future.then((incomeTransfer) {
            if (incomeTransfer != null) {
              setState(() {
                widget._transferList.add(incomeTransfer);
              });
            }
          });
        },
      ),
    );
  }
}