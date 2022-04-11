import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interviewtask/data/constants.dart';
import 'package:interviewtask/data/datasources/remote_data_source.dart';
import 'package:interviewtask/data/exception.dart';
import 'package:interviewtask/data/models/news_article.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);

    group('get news articles test', () async {
      final tNewsArticles = (json.decode(readJson(
              'helpers/dummy_data/dummy_news_articles.json"'))['value'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();
      test('should return list of news articles if response code is 200', () {
        //arrange
        when(mockHttpClient.get(Uri.parse(Urls.newsUrl(1, 10, "ar"))))
            .thenAnswer((realInvocation) async => http.Response(
                readJson("helpers/dummy_data/dummy_news_articles.json"), 200));
      });

      //act
      final result = await dataSource.getNewsArticles(1, 10, "ar");

      //assert
      expect(result, equals(tNewsArticles));
    });

    test('should throw server exception when the response code is 404 ', () {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.newsUrl(1, 10, "ar")))).thenAnswer(
          (realInvocation) async => http.Response('Not Found', 404));

      //act
      final res = dataSource.getNewsArticles(1, 10, "ar");

      //assert
      expect(() => res, throwsA(isA<ServerException>()));
    });
  });
}
