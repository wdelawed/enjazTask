import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final String name;
  final String imageUrl;
  final String description;

  const NewsArticle(
      {required this.name, required this.imageUrl, required this.description});
  @override
  List<Object?> get props => [name, imageUrl, description];
}
