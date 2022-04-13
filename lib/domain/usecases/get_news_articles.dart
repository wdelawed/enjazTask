import 'package:dartz/dartz.dart';
import 'package:interviewtask/data/failure.dart';
import 'package:interviewtask/data/models/news_article.dart';
import 'package:interviewtask/domain/repositories/news_article_repository.dart';

class GetNewsArticle {
  final NewsArticlesRepository newsArticlesRepository;
  GetNewsArticle({required this.newsArticlesRepository});

  Future<Either<Failure, List<NewsArticleModel>>> execute(
      int page, int size, String langCode) async {
    return newsArticlesRepository.getNewsArticles(page, size, langCode);
  }
}
