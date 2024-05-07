import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<List> fetch(String search) async {
  String url =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&pageSize=100&apiKey=65543adc152e4afaa9a89fcd9207d7d0&q=$search";
  var response = await http.get(Uri.parse(url));

  Map data = jsonDecode(response.body);

  List articles = data["articles"];
  log(articles.toString());

  return articles;
}
