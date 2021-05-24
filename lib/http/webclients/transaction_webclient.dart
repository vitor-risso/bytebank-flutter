import 'dart:convert';

import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(baseUrl));

    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((dynamic json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String pwd) async {
    final String finalTransaction = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json", "password": pwd},
      body: finalTransaction,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response));
  }

  String _getMessage(Response response) {
    if (_statusCodeResponses.containsKey(response.statusCode)) {
      return _statusCodeResponses[response.statusCode];
    }

    return "Unknown error";
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "There was an error while submitting transfer",
    401: "Authentication failed",
    409: "You've the same transaction a short time ago"
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
