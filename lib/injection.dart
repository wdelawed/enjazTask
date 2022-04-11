import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:interviewtask/data/repositories/news_articles_repository.dart';
import 'package:interviewtask/domain/repositories/news_article_repository.dart';
import 'package:interviewtask/domain/usecases/get_current_weather.dart';
import 'package:interviewtask/presentation/bloc/news_article_bloc.dart';

import 'data/datasources/remote_data_source.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => NewsArticleBloc(locator()));

  // usecase
  locator.registerLazySingleton(
      () => GetNewsArticle(newsArticlesRepository: locator()));

  // repository
  locator.registerLazySingleton<NewsArticlesRepository>(
    () => NewsArticlesRepositoryImp(
      dataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
