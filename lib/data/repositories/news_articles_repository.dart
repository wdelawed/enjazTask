import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:interviewtask/data/datasources/remote_data_source.dart';
import 'package:interviewtask/data/exception.dart';
import 'package:interviewtask/data/models/news_article.dart';
import 'package:interviewtask/domain/repositories/news_article_repository.dart';

import '../failure.dart';

class NewsArticlesRepositoryImp implements NewsArticlesRepository {
  RemoteDataSource dataSource;
  NewsArticlesRepositoryImp({required this.dataSource});

  @override
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles(
      int page, int size, String langCode) async {
    try {
      final res = await dataSource.getNewsArticles(page, size, langCode);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      //TODO: localize exception messages
      return const Left(ConnectionFailure('failed to connect to the server'));
    }
  }
}
