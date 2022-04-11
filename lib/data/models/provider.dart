import 'package:collection/collection.dart';

import 'image.dart';

class Provider {
  final String? type;
  final String? name;
  final Image? image;

  const Provider({this.type, this.name, this.image});

  @override
  String toString() => 'Provider(type: $type, name: $name, image: $image)';

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        type: json['_type'] as String?,
        name: json['name'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        '_type': type,
        'name': name,
        'image': image?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Provider) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => type.hashCode ^ name.hashCode ^ image.hashCode;
}
