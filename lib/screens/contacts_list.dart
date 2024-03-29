import 'package:bytebank/components/items.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_forms.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Contacts";

class ContactsList extends StatelessWidget {
  final ContactDAO _dao = ContactDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ContactItem(
                    contact,
                    onCLick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TransactionForm(contact)));
                    },
                  );
                },
              );
              break;
          }
          return null;
        },
      ),
      appBar: AppBar(title: Text(_appBarTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForms();
          }));
        },
      ),
    );
  }
}
