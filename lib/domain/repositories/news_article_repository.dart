import 'package:dartz/dartz.dart';

import 'package:interviewtask/data/failure.dart';
import 'package:interviewtask/data/models/news_article.dart';

abstract class NewsArticlesRepository {
  Future<Either<Failure, List<NewsArticleModel>>> getNewsArticles(
      int page, int size, String langCode);
}
