import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewtask/domain/usecases/get_current_weather.dart';
import 'package:interviewtask/presentation/bloc/news_article_event.dart';
import 'package:interviewtask/presentation/bloc/news_article_state.dart';

class NewsArticleBloc extends Bloc<NewsArticlesEvent, NewsArticlesState> {
  final GetNewsArticle _getNewsArticle;

  late int currentPage;
  late int pageSize;
  late String languageCode;
  NewsArticleBloc(this._getNewsArticle) : super(NewsArticlesEmpty()) {
    on<OnLoadNewsPage>((event, emit) async {
      currentPage = event.pageNo;
      pageSize = event.pageSize;
      languageCode = event.languageCode;
      emit(NewsArticlesLoading());
      final _res = await _getNewsArticle.execute(
          event.pageNo, event.pageSize, event.languageCode);
      _res.fold((failure) {
        emit(NewsArticlesErrorState(message: failure.message));
      }, (data) {
        emit(NewsArticlesHasData(
            articles: data.map((e) => e.toEntity()).toList()));
      });
    });

    on<OnLoadNextPage>((event, emit) async {
      emit(NewsArticlesLoadingNextPageState());
      currentPage = event.currrentPage + 1;
      final _res =
          await _getNewsArticle.execute(currentPage, pageSize, languageCode);
      _res.fold((failure) {
        emit(NewsArticlesErrorState(message: failure.message));
      }, (data) {
        emit(NewsArticlesHasData(
            articles: data.map((e) => e.toEntity()).toList()));
      });
    });
  }
}
