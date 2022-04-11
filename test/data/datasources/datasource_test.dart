import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:interviewtask/data/constants.dart';
import 'package:interviewtask/data/datasources/remote_data_source.dart';
import 'package:interviewtask/data/exception.dart';
import 'package:interviewtask/data/models/news_article.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late Client httpClient;
  late RemoteDataSourceImpl dataSource;
  late RemoteDataSourceImpl realDataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
    httpClient = Client();
    realDataSource = RemoteDataSourceImpl(client: httpClient);
  });

  group('get news articles test', () {
    test('should return a valid news articles list ', () async {
      //act
      final result = await realDataSource.getNewsArticles(1, 10, "ar");

      //assert
      expect(result, isInstanceOf<List<NewsArticleModel>>());
    });

    test('should throw server exception when the response code is 404 ', () {
      //arrange
      when(mockHttpClient.get(Uri.parse(Urls.newsUrl(1, 10, "ar")),
              headers: Urls.headers))
          .thenAnswer(
              (realInvocation) async => http.Response('Not Found', 404));

      //act
      final res = dataSource.getNewsArticles(1, 10, "ar");

      //assert
      expect(() => res, throwsA(isA<ServerException>()));
    });
  });
}
