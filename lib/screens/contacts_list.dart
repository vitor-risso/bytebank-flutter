import 'package:bytebank/components/items.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Contacts";

class ContactsList extends StatelessWidget {
  final List<Contact> _contactList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: findAll(),
        builder: (context, snapshot) {
          final List<Contact> contacts = snapshot.data;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ContactItem(contact);
            },
          );
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
        },
      ),
    );
  }
}
