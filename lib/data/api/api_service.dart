import 'dart:convert';

import 'package:dicoding_news_app/data/models/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://newsapi.org/v2/';
  static final String _apiKey = '5ee1d93d7ee04acebca6a721e338af86';
  static final String _category = 'business';
  static final String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final response = await http.get(_baseUrl +
        "top-headlines?country=$_country&category=$_category&apiKey=$_apiKey");
    if (response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
