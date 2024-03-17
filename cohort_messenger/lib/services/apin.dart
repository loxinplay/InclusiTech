import 'dart:convert' as convert;

import 'package:http/http.dart' as http;


void main(List<String> arguments) async {
  // This example will fetch a random quote from the
  // dummyjson.com service...
  final url = Uri.http('127.0.0.1:5000', '/');

  // You can hover your cursor over the .get() method to learn more about it, or,
  // right click it and select 'Go to Definition' to view the source.
  final response = await http.get(url);

  // ...and print the quote if the fetch was succesful.
  if (response.statusCode == 200) {
    final json = convert.jsonDecode(response.body);
    print(json);
  } else {
    print('Request failed with code: ${response.statusCode}.');
  }
}