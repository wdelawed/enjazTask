import 'package:equatable/equatable.dart';

abstract class NewsArticlesEvent extends Equatable {
  const NewsArticlesEvent();
  @override
  List<Object?> get props => [];
}

class OnLoadNewsPage implements NewsArticlesEvent {
  final int pageNo;
  final int pageSize;
  final String languageCode;
  OnLoadNewsPage(
      {required this.pageNo,
      required this.pageSize,
      required this.languageCode});
  @override
  List<Object?> get props => [pageNo, pageSize, languageCode];

  @override
  bool? get stringify => true;
}

class OnLoadNextPage extends NewsArticlesEvent {
  const OnLoadNextPage();
}
