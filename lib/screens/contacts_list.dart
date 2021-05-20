import 'package:bytebank/components/items.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Contacts";

class ContactsList extends StatefulWidget {
  final List<Contact> _contactList = [];

  @override
  State<StatefulWidget> createState() {
    return StateContactList();
  }
}

class StateContactList extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._contactList.length,
        itemBuilder: (context, index) {
          final contact = widget._contactList[index];
          return ContactItem(contact);
        },
      ),
      appBar: AppBar(title: Text(_appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Contact> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForms();
          }));
          future.then((incomeTransfer) {
            if (incomeTransfer != null) {
              setState(() {
                widget._contactList.add(incomeTransfer);
              });
            }
          });
        },
      ),
    );
  }
}
