import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "New contact";

class TransferForms extends StatefulWidget {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final ContactDAO _dao = ContactDAO();

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: widget._name,
                style: TextStyle(
                  fontSize: 24,
                ),
                decoration: InputDecoration(
                  labelText: "Full name",
                ),
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: widget._accountNumber,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  decoration: InputDecoration(
                    labelText: "Account number",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      _createAccount(context, widget._dao);
                    },
                    child: Text("Create"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _createAccount(BuildContext context, ContactDAO dao ) {
    final String name = widget._name.text.toString();
    final int accountNUmber =
    int.tryParse(widget._accountNumber.text.toString());
    if (name != null && accountNUmber != null) {
      final Contact finalContact = Contact(name, accountNUmber);
      dao.save(finalContact).then((value) =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContactsList();
          })));
    }
  }
}
