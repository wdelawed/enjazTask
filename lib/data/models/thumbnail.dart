import 'package:collection/collection.dart';

class Thumbnail {
  final String? type;
  final String? contentUrl;
  final int? width;
  final int? height;

  const Thumbnail({this.type, this.contentUrl, this.width, this.height});

  @override
  String toString() {
    return 'Thumbnail(type: $type, contentUrl: $contentUrl, width: $width, height: $height)';
  }

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        type: json['_type'] as String?,
        contentUrl: json['contentUrl'] as String?,
        width: json['width'] as int?,
        height: json['height'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_type': type,
        'contentUrl': contentUrl,
        'width': width,
        'height': height,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Thumbnail) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      type.hashCode ^ contentUrl.hashCode ^ width.hashCode ^ height.hashCode;
}
