import 'dart:convert';

import 'package:interviewtask/data/constants.dart';
import 'package:interviewtask/data/models/news_article.dart';
import 'package:http/http.dart' as http;

import '../exception.dart';

abstract class RemoteDataSource {
  Future<List<NewsArticleModel>> getNewsArticles(
      int page, int size, String langCode);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<NewsArticleModel>> getNewsArticles(
      int page, int size, String langCode) async {
    final response = await client.get(
        Uri.parse(Urls.newsUrl(page, size, langCode)),
        headers: Urls.headers);

    if (response.statusCode == 200) {
      return (json.decode(response.body)["value"] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
