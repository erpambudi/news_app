import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/models/article.dart';
import 'package:dicoding_news_app/utils/results_state.dart';
import 'package:flutter/cupertino.dart';

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({@required this.apiService}) {
    //dipanggil di constructor karena method private
    _fetchAllArticle();
  }

  ArticlesResult _articlesResult;
  String _message = "";
  ResultState _state;

  //membuat getter karena variabel private
  String get message => _message;

  ArticlesResult get result => _articlesResult;

  ResultState get state => _state;

  //tipe data dynamic karena yang di return tipe datanya dinamis
  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final article = await apiService.topHeadlines();

      if (article.articles.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "Empty Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _articlesResult = article;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
