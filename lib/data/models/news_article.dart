import 'package:collection/collection.dart';
import 'package:interviewtask/domain/enitities/news_article.dart';

import 'image.dart';
import 'provider.dart';

class NewsArticleModel {
  final String? type;
  final String? name;
  final String? url;
  final Image? image;
  final String? description;
  final List<Provider>? provider;
  final String? datePublished;

  const NewsArticleModel({
    this.type,
    this.name,
    this.url,
    this.image,
    this.description,
    this.provider,
    this.datePublished,
  });

  @override
  String toString() {
    return 'NewsArticle(type: $type, name: $name, url: $url, image: $image, description: $description, provider: $provider, datePublished: $datePublished)';
  }

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      NewsArticleModel(
        type: json['_type'] as String?,
        name: json['name'] as String?,
        url: json['url'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        description: json['description'] as String?,
        provider: (json['provider'] as List<dynamic>?)
            ?.map((e) => Provider.fromJson(e as Map<String, dynamic>))
            .toList(),
        datePublished: json['datePublished'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_type': type,
        'name': name,
        'url': url,
        'image': image?.toJson(),
        'description': description,
        'provider': provider?.map((e) => e.toJson()).toList(),
        'datePublished': datePublished,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NewsArticleModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      type.hashCode ^
      name.hashCode ^
      url.hashCode ^
      image.hashCode ^
      description.hashCode ^
      provider.hashCode ^
      datePublished.hashCode;
  NewsArticle toEntity() {
    return NewsArticle(
        name: name ?? "",
        imageUrl: image?.thumbnail?.contentUrl ?? "",
        description: description ?? "");
  }
}
