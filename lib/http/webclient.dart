import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data.body);
    return data;
  }
}

Future<List<Transaction>> findAll() async {
  final Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response = await client
      .get(Uri.parse("http://192.168.0.122:8080/transactions"))
      .timeout(Duration(seconds: 15));

  final List<dynamic> jsonList = jsonDecode(response.body);
  final List<Transaction> transactions = [];

  for (Map<String, dynamic> element in jsonList) {
    final Transaction transaction = Transaction(
      element['value'],
      Contact(element['contact']['name'], element['contact']['accountNumber']),
    );
    transactions.add(transaction);
  }

  return transactions;
}
