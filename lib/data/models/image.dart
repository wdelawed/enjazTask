import 'package:collection/collection.dart';

import 'thumbnail.dart';

class Image {
  final String? type;
  final Thumbnail? thumbnail;
  final bool? isLicensed;

  const Image({this.type, this.thumbnail, this.isLicensed});

  @override
  String toString() {
    return 'Image(type: $type, thumbnail: $thumbnail, isLicensed: $isLicensed)';
  }

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        type: json['_type'] as String?,
        thumbnail: json['thumbnail'] == null
            ? null
            : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
        isLicensed: json['isLicensed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        '_type': type,
        'thumbnail': thumbnail?.toJson(),
        'isLicensed': isLicensed,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Image) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => type.hashCode ^ thumbnail.hashCode ^ isLicensed.hashCode;
}
