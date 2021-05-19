import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

class TransferForms extends StatelessWidget {
  final TextEditingController _value = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando transferencia"),
      ),
      body: Column(
        children: [
          Editor(
              controller: _accountNumber,
              rotulo: "Numero da conta",
              tip: "000"),
          Editor(
              controller: _value,
              rotulo: "Valor",
              tip: "00.00",
              icon: Icons.monetization_on),
          ElevatedButton(
            onPressed: () => _createTransfer(context),
            child: Text("Confirmar"),
          )
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final double value = double.tryParse(_value.text);
    final int accountNUmber = int.tryParse(_accountNumber.text);

    if (value != null && accountNUmber != null) {
      final Transfer finalTransfer = Transfer(value, accountNUmber);
      Navigator.pop(context, finalTransfer);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String rotulo;
  final String tip;
  final IconData icon;

  Editor({this.controller, this.rotulo, this.tip, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: tip,
          icon: icon != null ? Icon(icon) : null,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [TransferItem(Transfer(1.23, 32123))],
      ),
      appBar: AppBar(title: Text("Tranferencias")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer> future =
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TransferForms();
          }));
          future.then((incomeTransfer) => {});
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);
}
