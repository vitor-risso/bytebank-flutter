import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

void findAll() async {
  final Response response =
  await get(Uri(scheme: "http://179.159.39.85:8080/transactions"));
  debugPrint(response.body);
}
