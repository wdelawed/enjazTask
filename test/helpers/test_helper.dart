import 'package:interviewtask/data/datasources/remote_data_source.dart';
import 'package:interviewtask/domain/repositories/news_article_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NewsArticlesRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
