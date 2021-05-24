import 'dart:async';

import 'package:bytebank/components/progress.dart';
import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transactio_auth.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;
  final TransactionWebClient _webClient = TransactionWebClient();

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Progress(
                    msg: "Sending...",
                  ),
                ),
                visible: _sending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String pwd) {
                                _save(transactionCreated, pwd, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Transaction> _send(
      Transaction transactionCreated, String pwd, BuildContext context) async {
    final Transaction transaction =
        await widget._webClient.save(transactionCreated, pwd).catchError((e) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(
              e.message,
            );
          });
    }, test: (e) => e is TimeoutException).catchError((e) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(
              e.message,
            );
          });
    }, test: (e) => e is HttpException).catchError((e) {
      showDialog(
          context: context,
          builder: (contextDialog) {
            return FailureDialog(
              "Unknown error",
            );
          });
    }).whenComplete(() => setState(() {
              _sending = false;
            }));
    return transaction;
  }

  void _save(
      Transaction transactionCreated, String pwd, BuildContext context) async {
    setState(() {
      _sending = true;
    });

    final Transaction transaction =
        await _send(transactionCreated, pwd, context);

    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog("All right");
          });
      Navigator.pop(context);
    }
  }
}
