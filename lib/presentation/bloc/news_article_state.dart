import 'package:equatable/equatable.dart';
import 'package:interviewtask/domain/enitities/news_article.dart';

abstract class NewsArticlesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsArticlesEmpty extends NewsArticlesState {}

class NewsArticlesLoading extends NewsArticlesState {}

class NewsArticlesErrorState extends NewsArticlesState {
  final String message;
  NewsArticlesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class NewsArticlesHasData extends NewsArticlesState {
  final List<NewsArticle> articles;
  NewsArticlesHasData({required this.articles});
}

class NewsArticlesLoadingNextPageState extends NewsArticlesState {}
